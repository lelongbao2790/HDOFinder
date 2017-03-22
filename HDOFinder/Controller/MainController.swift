//
//  MainController.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Cocoa

class MainController: NSViewController, MovieFacadeDelegate {

    // -----------
    // MARK: - Properties
    // -----------
    @IBOutlet weak var tfInputLink: NSTextField!
    @IBOutlet weak var btnGetLink: NSButton!
    @IBOutlet weak var btnSingleFilm: NSButton!
    @IBOutlet weak var btnEpisodeFilm: NSButton!
    @IBOutlet weak var tfError: NSTextField!
    @IBOutlet weak var tfEpisode: NSTextField!
    @IBOutlet weak var tfLinkResponse: NSTextField!
    @IBOutlet weak var tfLinkSub: NSTextField!
    
    // -----------
    // MARK: - Life Cycle
    // -----------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config();
    }
    
    // -----------
    // MARK: - Helper Method
    // -----------
    
    /**
     * Config view
     */
    func config() {
        MovieFacade.shared.movieFacadeDelegate = self
    }
    
    /**
     * Request get link
     */
    func requestLink(token: String, movieId: String) -> Void {
        
        if btnSingleFilm.state == NSOnState {
            // Phim le
            MovieFacade.shared.requestLinkMovie(episode:Common.kDefaultEpi, link: tfInputLink.stringValue, movieID: movieId, token: token)
            
        } else if btnEpisodeFilm.state == NSOnState {
            // Phim bo
            if tfEpisode.stringValue.lengthOfBytes(using: .utf8) > 0 {
                
                MovieFacade.shared.requestLinkMovie(episode:tfEpisode.stringValue,
                                                    link: tfInputLink.stringValue,
                                                    movieID: movieId,
                                                    token: token)
            } else {
                showStatus(text: "Lỗi! Chưa nhập tập phim", isError: true)
            }
        } else {
            showStatus(text: "Lỗi! Loại phim chưa check", isError: true)
        }
    }
    
    /**
     * Validate field
     */
    func validateField() -> Bool {
        let token = MovieFacade.shared.tokenId
        if  token.lengthOfBytes(using: .utf8) > 0 &&
            tfInputLink.stringValue.lengthOfBytes(using: .utf8) > 0 &&
            tfInputLink.stringValue.contains(Common.kHTML) {
            return true
            
        } else {
            showStatus(text: "Lỗi! Kiểm tra link nhập vào", isError: true)
            return false
        }
    }
    
    func showStatus(text:String, isError:Bool) -> Void {
        if isError {
            tfError.textColor = NSColor.red
            tfError.stringValue = text
        } else {
            tfError.textColor = NSColor.blue
            tfError.stringValue = text
        }
    }
    
    // -----------
    // MARK: - IBAction
    // -----------
    @IBAction func btnSingleFilm(_ sender: Any) {
        tfEpisode.isEnabled = false
        
        if btnSingleFilm.state == NSOnState {
            if btnEpisodeFilm.state == NSOnState {
                btnEpisodeFilm.state = NSOffState;
            }
        }
    }
    
    @IBAction func btnEpisodeFilm(_ sender: Any) {
        tfEpisode.isEnabled = true
        
        if btnEpisodeFilm.state == NSOnState {
            if btnSingleFilm.state == NSOnState {
                btnSingleFilm.state = NSOffState;
            }
        }
    }
    
    @IBAction func btnGetLink(_ sender: Any) {
        showStatus(text: "Đang lấy link ...", isError: true)
        
        // Get movie id and token
        let movieId = MovieFacade.shared.getMovieId(link: tfInputLink.stringValue)
        let token = MovieFacade.shared.getToken(link: tfInputLink.stringValue)
        
        if validateField() {
            requestLink(token: token, movieId: movieId)
        }
    }
    
    // -----------
    // MARK: - Service Manager Delegate
    // -----------
    func requestLinkMovieSuccess(file: AnyObject?) {
        let movie = file as! MovieFile
        
        // Link google, m3u8
        if movie.level.count > 0 {
            for links in movie.level {
                if links.quality == "720p" {
                    tfLinkResponse.stringValue = links.file
                    break
                }
            }
        } else if movie.file.lengthOfBytes(using: .utf8) > 0 {
            tfLinkResponse.stringValue = movie.file
        } else {
            tfLinkResponse.stringValue = ""
            showStatus(text: "Chua có link xem phim", isError: true)
        }
    
        // Subtitle
        if movie.subtitle.count > 0 {
            for subs in movie.subtitle {
                if subs.code == "vi" {
                    tfLinkSub.stringValue = subs.file
                    break
                }
            }
        } else {
            tfLinkSub.stringValue = ""
        }
        
        showStatus(text: "Lấy link thành công", isError: false)
    }
    
    func requestLinkMovieFail(sender: AnyObject?) {
        showStatus(text: "Lấy link thất bại", isError: true)
    }
    
}
