// --------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the ""Software""), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
// --------------------------------------------------------------------------

import CoreData
import Foundation

internal class BlobDownloadInitialOperation: ResumableOperation {
    // MARK: Initializers

    public convenience init(withTransfer transfer: BlockTransfer, queue: ResumableOperationQueue) {
        self.init(state: transfer.state)
        self.transfer = transfer
        self.queue = queue
        transfer.operation = self
    }

    // MARK: Internal Methods

    internal func queueRemainingBlocks(forTransfer transfer: BlobTransfer) {
        guard transfer.transferType == .download,
            let opQueue = queue,
            let downloader = transfer.downloader,
            downloader.blockList.count > 0,
            let context = transfer.managedObjectContext else {
            assertionFailure("Preconditions failed for queueRemainingBlocks")
            return
        }

        // The intialDownloadOperation marks the transfer complete, so
        // if blocks remain, we must reset the state to inProgress.
        transfer.state = .inProgress

        var operations = [ResumableOperation]()
        let finalOperation = BlobDownloadFinalOperation(withTransfer: transfer, queue: opQueue)
        operations.append(finalOperation)

        for block in downloader.blockList {
            let blockTransfer = BlockTransfer.with(
                context: context,
                startRange: Int64(block.startIndex),
                endRange: Int64(block.endIndex),
                parent: transfer
            )
            transfer.blocks?.adding(blockTransfer)
            let blockOperation = BlockOperation(withTransfer: blockTransfer)
            finalOperation.addDependency(blockOperation)
            operations.append(blockOperation)
        }
        queue?.add(operations)
        transfer.totalBlocks = Int64(transfer.transfers.count)
        transfer.operation = finalOperation
    }

    // MARK: Public Methods

    public override func main() {
        if isCancelled || isPaused { return }
        guard let transfer = self.transfer as? BlockTransfer,
            let parent = transfer.parent,
            parent.transferType == .download,
            let downloader = parent.downloader else {
            assertionFailure("Preconditions failed for BlobDownloadInitialOperation")
            return
        }

        transfer.state = .inProgress
        parent.state = .inProgress
        delegate?.operation(self, didChangeState: transfer.state)

        let group = DispatchGroup()
        group.enter()
        downloader.initialRequest { result, _ in
            switch result {
            case .success:
                transfer.state = .complete
                self.notifyDelegate(withTransfer: transfer)
                self.queueRemainingBlocks(forTransfer: parent)
            case let .failure(error):
                transfer.state = .failed
                parent.state = .failed
                parent.error = error
                self.notifyDelegate(withTransfer: transfer)
            }
            group.leave()
        }
        group.wait()
        parent.initialCallComplete = true
        super.main()
    }
}

internal class BlobDownloadFinalOperation: ResumableOperation {
    // MARK: Initializers

    public convenience init(withTransfer transfer: BlobTransfer, queue: ResumableOperationQueue) {
        self.init(state: transfer.state)
        self.transfer = transfer
        self.queue = queue
        transfer.operation = self
    }

    // MARK: Public Methods

    public override func main() {
        guard let transfer = self.transfer as? BlobTransfer else { return }
        transfer.state = .complete
        delegate?.operation(self, didChangeState: transfer.state)
        super.main()
    }
}