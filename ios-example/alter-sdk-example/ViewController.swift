//
//  Copyright © 2021 Omnipresence, Inc. All rights reserved.
//  Confidential, do not distribute
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  ONLY FOR TESTING AND DEMO PURPOSES, NO DISTRIBUTON
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit
import AlterSDK
import AlterCore

class MainViewController: UIViewController {

    @IBOutlet weak var avatarViewContainer: UIView!
    @IBOutlet weak var viewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnOpenDesigner: UIButton!
    
    var avatarMatrix: AvatarMatrix? = nil
    
    private var factory: AvatarFactory!
    private var designer: AvatarDesigner!
    private var avatarView: AvatarView!
    private var animatingAvatarController: AnimatingAvatarController?
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        /// For other samples of avatar setup and use including avatar controllers and tracking, see https://github.com/facemoji/alter-core
        designer = AvatarDesigner.create(self, "YOUR-API-KEY-HERE", faceTrackerUse: .onDemand).orThrow
        factory = designer.avatarFactory
        designer.stopTrackerWhenDesignerCloses = false // true if we wanted to re-use the tracking avatar controller for our own AvatarView
        
        setupIdleAnimation()
        loadRandomAvatar()
        
        // Create a view that will display the user’s avatar
        avatarView = AvatarView(frame: avatarViewContainer.frame)
        avatarViewContainer.insertSubview(avatarView, at: 0)
        layoutViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        avatarView.addGestureRecognizer(tap)
    }
    
    /// Animates the avatar expression using a pre-recorded animation
    private func setupIdleAnimation() {
        AnimatingAvatarController
            .create("idleAnimation.json", factory.dataFileSystem)
            .logError("Failed to load idle animation")
            .whenDone {[weak self] finalController in
                self?.animatingAvatarController = finalController
                self?.avatarView.avatarController = finalController
            }
    }
       
    /// Loads a random avatar
    private func loadRandomAvatar() {
        self.viewActivityIndicator.isHidden = false
        designer.getRandomAvatarMatrix().logError().whenDone { [weak self] avatarMatrix in
            self?.loadAvatar(avatarMatrix)
        }
    }
    
    /// Loads a specific avatar and displays it in AvatarView
    private func loadAvatar(_ avatarMatrix: AvatarMatrix?) {
        guard let avatarMatrix = avatarMatrix else { return }
        factory
            .createAvatarFromMatrix(avatarMatrix)
            .logError("Error loading avatar")
            .whenDone { [weak self] avatar in
                guard  let theSelf = self, let theAvatar = avatar else {
                    return
                }
                theSelf.avatarView.avatar = avatar
                if let theController = theSelf.animatingAvatarController {
                    theSelf.avatarView.avatarController = ViewportFitAvatarController(theController, theAvatar)
                }
                Foundation.DispatchQueue.main.async {
                    theSelf.viewActivityIndicator.isHidden = true
                }
            }
    }
    
    @IBAction func onOpenDesignerClick(_ sender: Any) {
        avatarView.pauseRendering(nil)
        designer.showDesigner(self.avatarMatrix).whenDone { [weak self] avatarMatrix in
            guard let theSelf = self else {
                return
            }
            theSelf.avatarView.resumeRendering()
            theSelf.avatarMatrix = avatarMatrix ?? theSelf.avatarMatrix
            theSelf.loadAvatar(avatarMatrix)
        }
    }
    
    @IBAction func onInfoClick(_ sender: Any) {
        if let link = URL(string: "https://alter.xyz") {
          UIApplication.shared.open(link)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if self.avatarMatrix == nil {
            loadRandomAvatar()
        }
    }
    
    /// Sets dynamic constraints for UI views that have been created 
    private func layoutViews() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: avatarViewContainer.topAnchor),
            avatarView.leftAnchor.constraint(equalTo: avatarViewContainer.leftAnchor),
            avatarView.rightAnchor.constraint(equalTo: avatarViewContainer.rightAnchor),
            avatarView.bottomAnchor.constraint(equalTo: avatarViewContainer.bottomAnchor)
        ])
    }
}

