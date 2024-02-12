import AVFoundation
import Constraints
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var content = UIView()
    
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Отсканируйте QR-код или бар код"
        return label
    }()
    
    
    var scanerImaga = UIImageView(image: UIImage(named: "Picel"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(content)
        content.addSubview(infoLabel)
      
        view.addSubview(scanerImaga)
        
        setup()
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = "Список вещей"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: (view.frame.width - 200) / 2, y: (view.frame.height - 387) / 2, width: 204, height: 204)

        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.cornerRadius = 26
        content.layer.addSublayer(previewLayer)
        
        // Start the capture session on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            // Start the capture session on a background thread
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        // Push to the next controller
        let nextController = SaveProduktController()
        // nextController.scannedCode = stringValue
        navigationController?.pushViewController(nextController, animated: true)
    }
    
    func found(code: String) {
        print(code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    private func setup() {
        
        content.layout
            .box(in: view)
            .activate()
        
        infoLabel.layout
            .leading(67)
            .trailing(67)
            .bottom.equal(scanerImaga.top, 64)
            .activate()
        
        
        scanerImaga.layout
            .centerX(2)
            .centerY()
            .activate()
        
    }
    
}

