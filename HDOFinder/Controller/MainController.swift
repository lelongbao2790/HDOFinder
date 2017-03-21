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
        
        let movieId = MovieFacade.shared.getMovieId(link: tfInputLink.stringValue)
        let token = "NmY1MjY0NDQ0YzZiMzA2YzMzNTg1NDZkNjI1ODRlNDc1NTMyNWE0YjYxNTg2NTQ2MzMzMDMzMmI0NTQzNzc2OTM4NDEzZDNk"
        
        if tfInputLink.stringValue.lengthOfBytes(using: .utf8) > 0 && tfInputLink.stringValue.contains(".html") {

            if btnSingleFilm.state == NSOnState {
                // Phim le
                MovieFacade.shared.requestLinkMovie(episode:"1", link: tfInputLink.stringValue, movieID: movieId, token: token)
                
            } else if btnEpisodeFilm.state == NSOnState {
                // Phim bo
                if tfEpisode.stringValue.lengthOfBytes(using: .utf8) > 0 {
                    MovieFacade.shared.requestLinkMovie(episode:tfEpisode.stringValue, link: tfInputLink.stringValue, movieID: movieId, token: token)
                } else {
                    showError(error: "Lỗi! Chưa nhập tập phim")
                }
            } else {
                showError(error: "Lỗi! Loại phim chưa check")
            }
        } else {
            showError(error: "Lỗi! Kiểm tra link nhập vào")
        }
    }
    
    func showError(error:String) -> Void {
        tfError.textColor = NSColor.red
        tfError.stringValue = error
    }
    
    func showGetLinkSuccess() -> Void {
        tfError.textColor = NSColor.blue
        tfError.stringValue = "Lấy link thành công"
    }
    
    // -----------
    // MARK: - Service Manager Delegate
    // -----------
    func requestLinkMovieSuccess(file: AnyObject?) {
        let movie = file as! MovieFile
        for links in movie.level {
            if links.quality == "720p" {
                tfLinkResponse.stringValue = links.file
                break
            }
        }
        
        for subs in movie.subtitle {
            if subs.code == "vi" {
                tfLinkSub.stringValue = subs.file
                break
            }
        }
        
        showGetLinkSuccess()
    }
    
    func requestLinkMovieFail(sender: AnyObject?) {
        showError(error: "Lấy link thất bại")
    }
    
}
