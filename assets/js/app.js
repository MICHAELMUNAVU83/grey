// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

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
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";
console.log("rtyurtyui")

let Hooks = {};
Hooks.addform={
  mounted(){
    console.log("it has started")
    const form = document.getElementById('formdiv');
    const addButton = document.getElementById('addButton');
    
    addButton.addEventListener('click', function() {
      console.log("i havve been clicked!")
      // Create a new set of form elements
      const newFormElement = `
      <div class="flex-col w-[100%] gap-2">
      <div class="w-[100%] flex justify-between">
        <div class="w-[30%] flex flex-col gap-2">
          <label for="item" class="text-xl text-[#0F52BA]">Item</label>
          <input
            type="text"
            name="item[]"
            id="datalist"
            list="items"
            class="w-[100%] h-[50px] border-2 my-2 border-[#259BFF] rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#259BFF] focus:border-transparent"
            phx-hook="datalist1"
          />
          <datalist id="items">
            <!-- Add options here -->
          </datalist>
        </div>

        <div class="w-[30%] flex flex-col gap-2">
          <label for="quantity" class="text-xl text-[#0F52BA]">Quantity</label>
          <input
            type="text"
            name="quantity[]"
            id="quantity"
            class="w-[100%] h-[50px] border-2 my-2 border-[#259BFF] rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#259BFF] focus:border-transparent"
          />
        </div>
        <div class="w-[30%] flex flex-col gap-2">
        <label for="uom" class="text-base text-[#0F52BA]">Unit of Measurement</label>
        <select
          name="uom[]"
          id="uom"
          class="w-[100%] h-[50px] border-2 my-2 border-[#259BFF] rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#259BFF] focus:border-transparent"
        >
          <option value="" disabled selected>Select UOM</option>
            <option value="Carton">Carton</option>
            <option value="Pallet">Pallet</option>
            <option value="Container">Container</option>
            <option value="Box">Box</option>
            <option value="Bag">Bag</option>
            <option value="Drum">Drum</option>
            <option value="Piece">Piece</option>
            <option value="Roll">Roll</option>
            <option value="Bundle">Bundle</option>
            <option value="Other">Other</option>
        </select>
      </div>
      </div>

     
    </div>
      `;
    
      // Create a new div element and set its inner HTML to the newFormElement
      const newFormDiv = document.createElement('div');
      newFormDiv.innerHTML = newFormElement;
    
      // Append the new form element to the form
      form.append(newFormDiv);
    });
    
  },
  updated(){
    const form = document.getElementById('formdiv');
const addButton = document.getElementById('addButton');

addButton.addEventListener('click', function() {
  console.log("i havve been clicked!")
  // Create a new set of form elements
  const newFormElement = `
    <div class="flex-col w-[100%] gap-2">
      <div class="w-[100%] flex justify-between">
        <div class="w-[30%] flex flex-col gap-2">
          <label for="item" class="text-xl text-[#0F52BA]">Item</label>
          <input
            type="text"
            name="item[]"
            id="datalist"
            list="items"
            class="w-[100%] h-[50px] border-2 my-2 border-[#259BFF] rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#259BFF] focus:border-transparent"
            phx-hook="datalist1"
          />
          <datalist id="items">
            <!-- Add options here -->
          </datalist>
        </div>

        <div class="w-[30%] flex flex-col gap-2">
          <label for="quantity" class="text-xl text-[#0F52BA]">Quantity</label>
          <input
            type="text"
            name="quantity[]"
            id="quantity"
            class="w-[100%] h-[50px] border-2 my-2 border-[#259BFF] rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#259BFF] focus:border-transparent"
          />
        </div>
        <div class="w-[30%] flex flex-col gap-2">
        <label for="uom" class="text-base text-[#0F52BA]">Unit of Measurement</label>
        <select
          name="uom[]"
          id="uom"
          class="w-[100%] h-[50px] border-2 my-2 border-[#259BFF] rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#259BFF] focus:border-transparent"
        >
          <option value="" disabled selected>Select UOM</option>
            <option value="Carton">Carton</option>
            <option value="Pallet">Pallet</option>
            <option value="Container">Container</option>
            <option value="Box">Box</option>
            <option value="Bag">Bag</option>
            <option value="Drum">Drum</option>
            <option value="Piece">Piece</option>
            <option value="Roll">Roll</option>
            <option value="Bundle">Bundle</option>
            <option value="Other">Other</option>
        </select>
      </div>
      </div>

     
    </div>
  `;

  // Create a new div element and set its inner HTML to the newFormElement
  const newFormDiv = document.createElement('div');
  newFormDiv.innerHTML = newFormElement;

  // Append the new form element to the form
  form.append(newFormDiv);
});


  },

};
Hooks.SideBarCollapse = {
  mounted() {
    const menu = document.querySelector(".menu-content");
    const menuItems = document.querySelectorAll(".submenu-item");
    const subMenuTitles = document.querySelectorAll(".submenu .menu-title");

    menuItems.forEach((item, index) => {
      item.addEventListener("click", () => {
        menu.classList.add("submenu-active");
        item.classList.add("show-submenu");
        menuItems.forEach((item2, index2) => {
          if (index !== index2) {
            item2.classList.remove("show-submenu");
          }
        });
      });
    });

    subMenuTitles.forEach((title) => {
      title.addEventListener("click", () => {
        menu.classList.remove("submenu-active");
      });
    });
  },
  updated() {
    const menu = document.querySelector(".menu-content");
    const menuItems = document.querySelectorAll(".submenu-item");
    const subMenuTitles = document.querySelectorAll(".submenu .menu-title");

    menuItems.forEach((item, index) => {
      item.addEventListener("click", () => {
        menu.classList.add("submenu-active");
        item.classList.add("show-submenu");
        menuItems.forEach((item2, index2) => {
          if (index !== index2) {
            item2.classList.remove("show-submenu");
          }
        });
      });
    });

    subMenuTitles.forEach((title) => {
      title.addEventListener("click", () => {
        menu.classList.remove("submenu-active");
      });
    });
  },
};
Hooks.datalist1={
mounted(){
  document.getElementById('datalist').addEventListener('input', function(e) {
    var input = e.target,
        list = input.getAttribute('list'),
        options = document.querySelectorAll('#' + list + ' option'),
        hiddenInput = document.getElementById(input.getAttribute('id') + '-hidden'),
        inputValue = input.value;

    hiddenInput.value = inputValue;

    for(var i = 0; i < options.length; i++) {
        var option = options[i];

        if(option.innerText === inputValue) {
            hiddenInput.value = option.getAttribute('data-value');
            break;
        }
    }
});

},
updated(){
  document.getElementById('datalist').addEventListener('input', function(e) {
    var input = e.target,
        list = input.getAttribute('list'),
        options = document.querySelectorAll('#' + list + ' option'),
        hiddenInput = document.getElementById(input.getAttribute('id') + '-hidden'),
        inputValue = input.value;

    hiddenInput.value = inputValue;

    for(var i = 0; i < options.length; i++) {
        var option = options[i];

        if(option.innerText === inputValue) {
            hiddenInput.value = option.getAttribute('data-value');
            break;
        }
    }
});


},

  
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});
// connect if there are any LiveViews on the page
liveSocket.connect();

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

// connect if there are any LiveViews on the page

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
