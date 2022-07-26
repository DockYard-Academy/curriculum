export function init(ctx, payload) {
  ctx.importCSS("main.css")
  ctx.root.innerHTML = `
          <section id="hint">
            <details open>
            <summary class="hint__toggle">Hint:</summary>
            ${payload.possible_solution.replace(/\n/g, "\n<span class=\"new-line\"></span>").replace("<code>", "<code><span class=\"new-line\"></span>")}
            </details>
          </section>
          `;

  const hint = ctx.root.querySelector("#hint");
  hint.style.display = "none"

  ctx.handleEvent("attempt", ({ attempt }) => {
    // attempts start at 1 on the first render
    // displays hint after 2 attempts
    if (attempt >= 3) {
      hint.style.display = "block"
    }
  });
}