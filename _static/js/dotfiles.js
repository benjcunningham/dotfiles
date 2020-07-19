function addIcon() {

    const dotfilesLogo = "https://raw.githubusercontent.com/benjcunningham/dotfiles/master/docs/source/_static/js/dotfilesLogo.png";
    const image = document.createElement("img");
    image.setAttribute("src", dotfilesLogo);

    const div = document.createElement("div");
    div.appendChild(image);
    div.style.textAlign = "center";
    div.style.padding = "30px";

    const scrollDiv = document.querySelector(".wy-side-scroll");
    scrollDiv.prepend(div);

}

function onLoad() {
    addIcon();
}

window.addEventListener("load", onLoad);
