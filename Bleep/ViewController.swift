//
//  ViewController.swift
//  Bleep
//
//  Created by Shahid Ghafoor on 05/03/2021.
//

import UIKit
import AVFoundation
import GoogleMobileAds


class ViewController: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate {

    @IBOutlet weak var bleepButton: UIButton!
    var audioPlayer: AVAudioPlayer?
    
    // ads...
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = Bundle.main.path(forResource: "beep", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        
        // banner
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-6812853586050394/9299158331"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        
        // Interstitial
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-6812853586050394/4238403341",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                              }
            )
    }

    
    @IBAction func playBeep(_ sender: Any) {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
            bleepButton.setImage(UIImage(named: "normal.png"), for: .normal)
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
              } else {
                print("Ad wasn't ready")
              }
        } else {
            bleepButton.setImage(UIImage(named: "active.png"), for: .normal)
            audioPlayer?.play()
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: bottomLayoutGuide,
                            attribute: .top,
                            multiplier: 1,
                            constant: 0),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
          } else {
            print("Ad wasn't ready")
          }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
          } else {
            print("Ad wasn't ready")
          }
    }
    
}

