import SwiftUI
import PDFKit

struct InformationView: View {
    @EnvironmentObject var router: Router
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
            // Using the PDFKitView and passing the previously created pdfURL
            PDFKitView(url: url)
                .scaledToFill()
                .colorInvert()
                .background(.black)
    }
}


struct PDFKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayDirection = .vertical
        pdfView.displayMode = .singlePage
        pdfView.pageBreakMargins = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) { }
}

#Preview {
    InformationView(url: Bundle.main.url(forResource: "Privacidad", withExtension: "pdf")!)
}
