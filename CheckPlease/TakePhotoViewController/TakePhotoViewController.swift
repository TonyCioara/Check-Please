//
//  TakePhotoViewController.swift
//  CheckPlease
//
//  Created by Erik Perez on 9/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class TakePhotoViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Take photo"
        view.backgroundColor = .yellow
        buildCameraPreviewLayer()
        let backgroundButtonViews = buildBackgroundButtonViews()
        buildButtons(withBackgroundView: backgroundButtonViews.background,
                     midLineView: backgroundButtonViews.midLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not supported")
    }
    
    // MARK: - Private
    
    private func buildBackgroundButtonViews() -> (background: UIView, midLine: UIView) {
        let backgroundButtonView = UIView()
        backgroundButtonView.backgroundColor = AppColors.mediumBlue
        view.addSubview(backgroundButtonView)
        backgroundButtonView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.height.equalTo(60)
        }
        
        let midLineView = UIView()
        backgroundButtonView.addSubview(midLineView)
        midLineView.backgroundColor = .white
        midLineView.snp.makeConstraints { maker in
            maker.width.equalTo(1)
            maker.centerX.equalToSuperview()
            maker.top.bottom.equalToSuperview().inset(15)
        }
        
        return (backgroundButtonView, midLineView)
    }
    
    private func buildButtons(withBackgroundView backgroundView: UIView, midLineView: UIView) {
        let buttonMaker: (String) -> UIButton = { title in
            let button = UIButton()
            button.backgroundColor = .clear
            button.titleLabel?.font = AppFonts.bold18
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            backgroundView.addSubview(button)
            return button
        }
        
        let takePhotoButton = buttonMaker("Take Photo")
        takePhotoButton.addTarget(self, action: #selector(takePhotoButtonPressed), for: .touchUpInside)
        takePhotoButton.snp.makeConstraints { maker in
            maker.leading.bottom.top.equalToSuperview()
            maker.trailing.equalTo(midLineView)
        }
        let confirmButton = buttonMaker("Confirm")
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        confirmButton.snp.makeConstraints { maker in
            maker.top.trailing.bottom.equalToSuperview()
            maker.leading.equalTo(midLineView)
        }
    }
    
    private func buildCameraPreviewLayer() {
        // TODO: Refactor
        let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
        let captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: cameraDevice),
            captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
    }
    
    @objc private func takePhotoButtonPressed() {
        print("\n* TakePhotoButtonPressed")
    }
    
    @objc private func confirmButtonPressed() {
        print("\n* ConfirmButtonPressed")
    }
}

extension TakePhotoViewController: UIImagePickerControllerDelegate {
    
}
