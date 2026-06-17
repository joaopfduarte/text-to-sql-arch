function initMermaid() {
  if (typeof mermaid === "undefined") {
    return;
  }

  document.querySelectorAll("pre.mermaid").forEach(function (pre) {
    var code = pre.querySelector("code");
    var source = code ? code.textContent : pre.textContent;
    var div = document.createElement("div");
    div.className = "mermaid";
    div.textContent = source.trim();
    pre.replaceWith(div);
  });

  mermaid.initialize({
    startOnLoad: false,
    theme: "neutral",
    securityLevel: "loose",
  });

  mermaid.run({ querySelector: ".mermaid" });
}

document.addEventListener("DOMContentLoaded", initMermaid);

if (typeof document$ !== "undefined") {
  document$.subscribe(initMermaid);
}
