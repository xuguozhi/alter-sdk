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

package alter.sdk.test.view

import alter.sdk.test.R
import android.content.Context
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatImageButton
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat

internal class RoundedButton @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null
) : AppCompatImageButton(context, attrs) {

    init {
        setup()
    }

    private fun setup() {

        setBackgroundResource(R.drawable.drawable_circle_background)

        val btnBackgroundDrawable = DrawableCompat.wrap(background)
        val btnImageDrawable = DrawableCompat.wrap(drawable)

        DrawableCompat.setTint(
            btnBackgroundDrawable,
            ContextCompat.getColor(context, R.color.white)
        )
        DrawableCompat.setTint(
            btnImageDrawable,
            ContextCompat.getColor(context, R.color.black8)
        )
    }

    override fun setEnabled(enabled: Boolean) {
        super.setEnabled(enabled)
        if (enabled) {
            enable()
        } else {
            disable()
        }
    }

    private fun disable() {
        imageAlpha = 255 / 2
    }

    private fun enable() {
        imageAlpha = 255
    }
}
