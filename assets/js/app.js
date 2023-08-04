// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Sortable from "../vendor/sortable"

let Hooks = {}

Hooks.Sortable = {
    mounted() {
        let sorter = new Sortable(this.el, {
            animation: 150,
            delay: 100,
            dragClass: "drag-item",
            ghostClass: "drag-ghost",
            forceFallback: true,
            fallbackTolerance: 10,
            onEnd: e => {
                const listItems = Array.from(this.el.children)
                const listIDs = listItems.map(listItem => listItem.id)
                let params = { listIDs }
                this.pushEventTo(this.el, "reposition", params)
            }
        })
    },

    updated() {
        const listItems = Array.from(this.el.children)
        const listIDs = listItems.map(listItem => listItem.id)
        let params = { listIDs }
        this.pushEventTo(this.el, "reposition", params)
    }
}

Hooks.PackItem = {
    mounted() {

        let inputForm = this.el.querySelector('.item-input')
        let displayElement = this.el.querySelector('.item-display')
        let inputTextField = inputForm.querySelector('input')

        let dragging = false


        let startX, startY


        function focusAtEnd(inputTextField) {
            const valueLength = inputTextField.value.length

            inputTextField.focus()
            inputTextField.setSelectionRange(valueLength, valueLength)
        }

        this.el.addEventListener('mousedown', (e) => {
            dragging = false

            startX = e.clientX
            startY = e.clientY
        })

        this.el.addEventListener('mousemove', (e) => {

            let dx = startX - e.clientX
            let dy = startY - e.clientY
            let distance = Math.sqrt(dx * dx + dy * dy)

            //console.log(distance)
            if (distance > 9) {
                dragging = true
            }
        })

        this.el.addEventListener('mouseup', () => {
            if (dragging) {
                return
            }


            if (inputForm.classList.contains('hidden')) {
                inputForm.classList.remove('hidden')
                displayElement.classList.add('hidden')
                focusAtEnd(inputTextField)
            }
        })

        inputTextField.addEventListener("blur", (event) => {
            inputForm.classList.add('hidden')
            displayElement.textContent = inputTextField.value //optimistic update
            displayElement.classList.remove('hidden')
        })
    }

}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks, params: { _csrf_token: csrfToken } })

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

