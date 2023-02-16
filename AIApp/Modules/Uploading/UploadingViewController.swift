import UIKit
import IGListKit
import Alamofire

class UploadingViewController: UIViewController {
    
    var mainView: UploadingView {
        return view as! UploadingView
    }
    
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = UploadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.bottomView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
                
        let images = Array(PersonManager.shared.getPersons()![0].photos)
        uploadImage(images: images.compactMap { UIImage(data: $0 ?? Data()) }, apiKey: "sd_eda1h1G19zmkSwsb9gqRYkc3tHiKix") { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    print("❤️ success completion uploadImage with wrong data DATA IS NILL")
                    return
                }
                print("💙 success complition with json:", data)
                
            case .failure(let error):
                print("❤️ failure complition uploadImage with error:", error)
            }
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        
//    }
    
    @objc private func continueButtonTapped() {
        let vc = AttentionViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }
    
    func uploadImage(images: [UIImage], apiKey: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let DOMAIN = "https://api.astria.ai"
        
        let url = URL(string: DOMAIN + "/tunes")
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")

        let formData = NSMutableData()
        let boundary = "Boundary-\(UUID().uuidString)"

        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"tune[title]\"\r\n\r\n".data(using: .utf8)!)
        formData.append("TEST\r\n".data(using: .utf8)!)

        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"tune[branch]\"\r\n\r\n".data(using: .utf8)!)
        formData.append("fast\r\n".data(using: .utf8)!)

        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"tune[token]\"\r\n\r\n".data(using: .utf8)!)
        formData.append("zwx\r\n".data(using: .utf8)!)

        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"tune[name]\"\r\n\r\n".data(using: .utf8)!)
        formData.append("man\r\n".data(using: .utf8)!)

        for image in images {
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            let filename = image.accessibilityIdentifier ?? "ImageName-\(Int.random(in: 0...100000))"
            let mimetype = "image/jpeg"
            
            formData.append("--\(boundary)\r\n".data(using: .utf8)!)
            formData.append("Content-Disposition: form-data; name=\"tune[images][]\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            formData.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            
            formData.append(data)
            formData.append("\r\n".data(using: .utf8)!)
        }
        
//        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
//        formData.append("Content-Disposition: form-data; name=\"tune[callback]\"\r\n\r\n".data(using: .utf8)!)
//        formData.append("https://optional-callback-url.com/to-your-service-when-ready\r\n".data(using: .utf8)!)

        formData.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("\(formData.length)", forHTTPHeaderField: "Content-Length")
        request.httpBody = formData as Data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response: \(json)")
                } catch {
                    print("Error: \(error)")
                }
                completion(.success(String(data: data, encoding: .utf8)))
            }
        }

        task.resume()
    }
    
    func photoDataToFormData(data: Data, boundary: String) -> Data {
        var fullData = Data()
        
        let lineOne = "--" + boundary + "\r\n"
        fullData.append(lineOne.data(using: .utf8)!)
        
        let lineTwo = "Content-Disposition: form-data; name=\"tune[images][]\"\r\n"
        fullData.append(lineTwo.data(using: .utf8)!)
        
        let lineFive = "\r\n"
        fullData.append(lineFive.data(using: .utf8)!)
        
        fullData.append(data)
        
        let lineSix = "\r\n"
        fullData.append(lineSix.data(using: .utf8)!)

        return fullData
    }

func testRequest() {
    //    AF.upload(multipartFormData: { (multipartFormData) in
    //        for (key, value) in parameters {
    //            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
    //        }
    //        for (index, image) in images.enumerated() {
    //            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
    //            multipartFormData.append(imageData, withName: "tune[images][]", fileName: "image\(index).jpeg", mimeType: "image/jpeg")
    ////                multipartFormData.append(imageData, withName: "tune[images][]")
    //        }
    //    }, to: url, headers: headers).responseString { response in
    //        switch response.result {
    //        case .success(let data):
    //            completion(.success(data))
    //
    //        case .failure(let error):
    //            completion(.failure(error))
    //        }
}
    
}

// MARK: - ListAdapterDataSource

extension UploadingViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [NewPacksModel(name: "morePacks")]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = NewPacksSection(headerType: .oneTimeOffer)
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - NewPacksDelegate

extension UploadingViewController: NewPacksDelegate {
    func newPacks(getPack index: Int) {
        
    }
}
