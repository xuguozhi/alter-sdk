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
import AlterCore

class IdleAnimationAvatarController: AvatarController {
    private let timer = Timer.start()
    private var scale: Double = 1

    func frame() -> AvatarAnimationData? {
        let time = Float(timer.tick().elapsed)
        let smile = Float(0.5 + 0.5 * sin(time * 0.5))
        return AvatarAnimationData(
            [
                "mouthSmile_L": smile,
                "mouthSmile_R": smile
            ],
            AvatarAnimationData.DEFAULT_AVATAR_POSITION,
            Quaternion.fromRotation(0.3 * sin(time * 0.5), Vec3.zAxis),
            Vec3.one.times(scale)
        )
    }
}
