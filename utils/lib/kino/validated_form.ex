defmodule Kino.ValidatedForm do
  @moduledoc """
  LiveSlide is a custom slideshow component for Livebook.
  """

  use Kino.JS

  def new(fields) do
    Kino.JS.new(__MODULE__, fields)
  end

  asset "main.js" do
    """

    export function init(ctx, fields) {
      ctx.importCSS("main.css");
      for (let i = 0; i < fields.length; i++) {
          const field = fields[i]

          if (field.options) {
            ctx.root.innerHTML += `
                <div class="container">
                  <div class="label">${field.label}</div>
                  <select class="input" id="field${i}">
                  ${field.options.map(each => `<option value="${each}">${each}</option>`)}
                  </select>
                </div>
              `
          } else {
            ctx.root.innerHTML += `
                <div class="container">
                  <div class="label">${field.label}</div>
                  <input class="input" id="field${i}" />
                </div>
              `
          }

      }

      for (let i = 0; i < fields.length; i++) {
        const element = document.getElementById("field" + i.toString())
        element.addEventListener("input", (event) => {
          const {answers: answers} = fields[i]
          if (answers.includes(event.target.value)) {
            element.classList.add("correct");
          } else {
            element.classList.remove("correct");
          }
        });
      }
    }
    """
  end

  asset "main.css" do
    """
    .container {
      padding-top: 20px;
    }
    .label {
      padding-bottom: 4px;
    }
    .input {
      --tw-border-opacity: 1;
      border-radius: 0.5rem;
      border-width: 1px;
      border: solid 1px rgb(225 232 240);
      font-size: .875rem;
      line-height: 1.25rem;
      padding: .5rem .75rem;
      box-sizing: border-box;
      background-color: #F8FAFC;
      width: 215px;
    }
    .input:focus {
      outline: none;
    }
    .correct {
      background-color: lightgreen;
    }
    """
  end
end
