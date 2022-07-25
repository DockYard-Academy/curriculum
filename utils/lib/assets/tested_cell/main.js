export function init(ctx, payload) {
    ctx.importCSS("main.css");

    ctx.root.innerHTML += `
            <section id="teacher_editor">
                <p>Assertions</p>
                <textarea class="editor" id="assertions_editor"></textarea>
                <p>Hint</p>
                <textarea class="editor" id="hint_editor"></textarea>
            </section>
            <section id="hint">
              <details open>
              <summary class="hint__toggle">Hint:</summary>
              ${payload.hint_html.replace(/\n/g, "\n<span class=\"new-line\"></span>").replace("<code>", "<code><span class=\"new-line\"></span>")}
              </details>
            </section>
            `;

    const teacher_editor = ctx.root.querySelector("#teacher_editor");
    const assertions_editor = ctx.root.querySelector("#assertions_editor");
    const hint_editor = ctx.root.querySelector("#hint_editor");

    if (payload.hide) {
        teacher_editor.style.display = "none"
    }

    assertions_editor.value = payload.assertions;
    hint_editor.value = payload.hint;

    assertions_editor.addEventListener("change", (event) => {
        ctx.pushEvent("update_assertions", { assertions: event.target.value });
    });

    hint_editor.addEventListener("change", (event) => {
        ctx.pushEvent("update_hint", { hint: event.target.value });
    });

    ctx.handleEvent("update_assertions", ({ assertions }) => {
        assertions_editor.value = assertions;
    });

    ctx.handleEvent("update_hint", ({ hint }) => {
        hint_editor.value = hint;
    });

    ctx.handleSync(() => {
        // Synchronously invokes change listeners
        document.activeElement &&
            document.activeElement.dispatchEvent(new Event("change"));
    });

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
