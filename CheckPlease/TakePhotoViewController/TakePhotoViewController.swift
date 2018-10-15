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
        view.backgroundColor = .white
        
        guard let captureSession = buildCaptureSession() else { return }
        buildCameraPreviewLayer(withCaptureSession: captureSession)
        let backgroundButtonViews = buildBackgroundButtonViews()
        buildPreviewImageView(withButtonBackgroundView: backgroundButtonViews.background)
        buildButtons(withBackgroundView: backgroundButtonViews.background,
                     midLineView: backgroundButtonViews.midLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not supported")
    }
    
    // MARK: - Private
    
    private var captureImageButton: UIButton?
    private var confirmButton: UIButton?
    private var previewImageView: UIImageView?
    
    private var photoSettings: AVCapturePhotoSettings?
    private var photoOutput: AVCapturePhotoOutput?
    private var imageData: Data? {
        didSet {
            confirmButton?.isEnabled = imageData != nil ? true : false
            guard let data = self.imageData else {
                captureImageButton?.setTitle("Take Photo", for: .normal)
                previewImageView?.image = nil
                return
            }
            captureImageButton?.setTitle("Retake", for: .normal)
            let image = UIImage(data: data)
            previewImageView?.image = image
        }
    }
    
    private func buildCaptureSession() -> AVCaptureSession? {
        guard let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return nil
        }
        let captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: cameraDevice),
            captureSession.canAddInput(videoDeviceInput) else {
                return nil
        }
        captureSession.addInput(videoDeviceInput)
        
        let photoOutput = AVCapturePhotoOutput()
        self.photoOutput = photoOutput
        photoOutput.isHighResolutionCaptureEnabled = true
        
        guard captureSession.canAddOutput(photoOutput) else {
            return nil
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        captureSession.startRunning()
        
        let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
        photoSettings.isHighResolutionPhotoEnabled = true
        self.photoSettings = photoSettings
    
        return captureSession
    }
    
    private func buildCameraPreviewLayer(withCaptureSession session: AVCaptureSession) {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
    }
    
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
    
    private func buildPreviewImageView(withButtonBackgroundView backgroundView: UIView) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        self.previewImageView = imageView
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(view.snp.topMargin)
            maker.bottom.equalTo(backgroundView.snp.top)
        }
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
        self.captureImageButton = takePhotoButton
        takePhotoButton.addTarget(self, action: #selector(takePhotoButtonPressed), for: .touchUpInside)
        takePhotoButton.snp.makeConstraints { maker in
            maker.leading.bottom.top.equalToSuperview()
            maker.trailing.equalTo(midLineView)
        }
        let confirmButton = buttonMaker("Confirm")
        confirmButton.isEnabled = false
        self.confirmButton = confirmButton
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        confirmButton.snp.makeConstraints { maker in
            maker.top.trailing.bottom.equalToSuperview()
            maker.leading.equalTo(midLineView)
        }
    }
    
    @objc private func takePhotoButtonPressed() {
        guard let photoOutput = self.photoOutput,
            let photoSettings = self.photoSettings else {
                return
        }
        // Only allow image capture if we don't have and image already. This case is hit when pressing "retake"
        guard imageData == nil else {
            imageData = nil
            return
        }
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(from: photoSettings), delegate: self)
    }
    
    @objc private func confirmButtonPressed() {
        print("\n* ConfirmButtonPressed")
        // TODO: Send image to backend
    }
}

extension TakePhotoViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.imageData = imageData
        print("\n* Image data: \(imageData)")
    }
}