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
                .padding(.top, 50)
                .imageScale(.large)
                .colorInvert()
                .background(.black)
                .ignoresSafeArea()
    }
}


struct PDFKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) { }
}

#Preview {
    InformationView(url: Bundle.main.url(forResource: "Privacidad", withExtension: "pdf")!)
}
