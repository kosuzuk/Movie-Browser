import SwiftUI

struct MovieListPageNumberView: View {
    @ObservedObject var viewModel: SearchViewModel
    let scrollToTopFunc: () -> ()
    
    private struct Constant {
        static let page1 = "1"
        static let previousButtonText = "<"
        static let nextButtonText = ">"
        static let firstPageButtonText = "<<"
        static let lastPageButtonText = ">>"
    }
    
    private func changePageWithScroll(_ newPage: Int) {
        viewModel.changePage(newPage: newPage)
        scrollToTopFunc()
    }
    
    var body: some View {
        HStack {
            Button(Constant.firstPageButtonText) {
                    changePageWithScroll(1)
            }
            .frame(width: 30, height: 30)
            .disabled(viewModel.isFirstPage)
            .foregroundColor(viewModel.isFirstPage ? .clear : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(viewModel.isFirstPage ? .clear : .gray, lineWidth: 1)
            )
            
            Spacer()
                .frame(width: 20)
            
            Button(Constant.previousButtonText) {
                    changePageWithScroll(viewModel.currentPage - 1)
            }
            .frame(width: 30, height: 30)
            .disabled(viewModel.isFirstPage)
            .foregroundColor(viewModel.isFirstPage ? .clear : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(viewModel.isFirstPage ? .clear : .gray, lineWidth: 1)
            )
            
            Spacer()
                .frame(width: 20)
            
            Text("\(viewModel.currentPage)/\(viewModel.totalPages)")
                .foregroundColor(.gray)
            
            Spacer()
                .frame(width: 20)
            
            Button(Constant.nextButtonText) {
                    changePageWithScroll(viewModel.currentPage + 1)
            }
            .frame(width: 30, height: 30)
            .disabled(viewModel.isLastPage)
            .foregroundColor(viewModel.isLastPage ? .clear : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(viewModel.isLastPage ? .clear : .gray, lineWidth: 1)
            )
            
            Spacer()
                .frame(width: 20)
            
            Button(Constant.lastPageButtonText) {
                changePageWithScroll(viewModel.totalPages)
            }
            .frame(width: 30, height: 30)
            .disabled(viewModel.isLastPage)
            .foregroundColor(viewModel.isLastPage ? .clear : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(viewModel.isLastPage ? .clear : .gray, lineWidth: 1)
            )
        }
    }
}
