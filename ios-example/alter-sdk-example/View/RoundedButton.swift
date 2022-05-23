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

class RoundedButton: UIButton {

    @IBInspectable var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        tintColor = UIColor.black.withAlphaComponent(0.8)
        backgroundColor = .white
        setTitle(nil, for: .normal)

    }


    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowRadius = 32.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 16.0)
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.cornerRadius = bounds.height/2
    }
}
