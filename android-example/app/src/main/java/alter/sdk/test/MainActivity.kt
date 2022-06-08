//
//  Copyright © 2022 Omnipresence, Inc. All rights reserved.
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

package alter.sdk.test

import alter.sdk.api.AvatarDesigner
import alter.sdk.common.AVATAR_FIT_SCALE
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.isVisible
import co.facemoji.ALTER_CORE_VERSION
import co.facemoji.avatar.*
import co.facemoji.avatar.data.AvatarMatrix
import co.facemoji.logging.Logger
import co.facemoji.logging.info
import co.facemoji.logging.logError
import co.facemoji.math.Col

class MainActivity : AppCompatActivity() {

    private var avatarMatrix: AvatarMatrix? = null
    private lateinit var factory: AvatarFactory
    private lateinit var avatarView: AvatarView
    private lateinit var designer: AvatarDesigner
    private lateinit var progressBar: ProgressBar
    private var animatingAvatarController: AnimatingAvatarController? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Logging setup
        Logger.printLogWithListeners = true // Always print to console
        Logger.info("Using AlterCore version $ALTER_CORE_VERSION")

        // Create a new avatar designer. Get your key at https://studio.alter.xyz.
        designer = AvatarDesigner.create(this, "YOUR-API-KEY-HERE").orThrow
        factory = designer.avatarFactory

        // Idle animation for the default avatar
        AnimatingAvatarController
            .create("idleAnimation.json", factory.dataFileSystem)
            .logError("Failed to load idle animation")
            .whenDone {
                animatingAvatarController = it
            }

        // Create a default AvatarView for displaying the created avatar
        val avatarViewContainer = findViewById<ViewGroup>(R.id.avatar_view)
        progressBar = findViewById(R.id.progress)
        avatarView = factory.createAvatarView()
        avatarViewContainer.addView(avatarView)
        avatarView.isOpaque = false

        avatarViewContainer.setOnClickListener {
            // Change avatar randomly when user taps it
            loadRandomAvatar()
        }

        loadRandomAvatar()
    }

    private fun loadRandomAvatar() {
        progressBar.isVisible = true
        designer.getRandomAvatarMatrix().logError().whenDone {
            loadAvatar(it)
        }
    }

    private fun loadAvatar(avatarMatrix: AvatarMatrix?) {
        avatarMatrix?.let { theMatrix ->
            factory
                .createAvatarFromMatrix(theMatrix)
                .logError("Error loading avatar")
                .whenDone { avatar ->
                    runOnUiThread {
                        progressBar.isVisible = false
                        avatarView.avatar = avatar ?: return@runOnUiThread

                        animatingAvatarController?.let { controller ->
                            avatarView.avatarController = ViewportFitAvatarController(
                                controller,
                                avatar,
                                AVATAR_FIT_SCALE
                            )
                        }
                    }
                }
        }
    }

    fun onFacemojiDesignerClick(view: View) {
        designer.showDesigner(avatarMatrix).whenDone { avatarMatrix ->
            // Called when the user finishes designing the avatar
            runOnUiThread {
                if (avatarMatrix == null) {
                    Logger.info("User cancelled avatar creation")
                } else {
                    Logger.info("User created the following avatar: \n${avatarMatrix.toJson()}")
                    progressBar.isVisible = false
                    this.avatarMatrix = avatarMatrix

                    // Load the selected avatar and display it in the AvatarView
                    factory.createAvatarFromMatrix(avatarMatrix).whenDone {
                        avatarView.avatar = it.optional
                        avatarView.avatar?.setBackgroundColor(Col.TRANSPARENT)
                        it.optional?.let { avatar ->
                            animatingAvatarController?.let { controller ->
                                avatarView.avatarController =
                                    ViewportFitAvatarController(controller, avatar)
                            }
                        }
                    }
                }
            }
        }
    }

    override fun onPause() {
        super.onPause()
        avatarView.pauseRendering { }
    }

    override fun onResume() {
        super.onResume()
        avatarView.resumeRendering()
    }

    fun onInfoClick(view: View) {
        val url = "http://alter.xyz"
        val intent = Intent(Intent.ACTION_VIEW)
        intent.data = Uri.parse(url)
        startActivity(intent)
    }
}
