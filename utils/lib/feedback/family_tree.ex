defmodule Utils.Feedback.FamilyTree do
  use Utils.Feedback.Assertion

  feedback :family_tree do
    family_tree = get_answers()
    assert is_map(family_tree) == true, "Ensure `family_tree` is a map."

    assert Map.get(family_tree, :name) == "Arthur",
           "Ensure `family_tree` starts with Arthur."

    assert match?(%{name: "Arthur", parents: _}, family_tree) == true,
           "Ensure Arthur in `family_tree` has a list of parents."

    assert family_tree == Utils.Feedback.FamilyTree.family_tree(),
           "Ensure your `family_tree` matches the expected value and order."
  end

  def family_tree do
    han = %{
      name: "Han",
      status: :grand_parent,
      age: 81,
      parents: []
    }

    leia = %{
      name: "Leia",
      status: :grand_parent,
      age: 82,
      parents: []
    }

    uther = %{
      name: "Uther",
      status: :parent,
      age: 56,
      parents: [han, leia]
    }

    bob = %{
      name: "Bob",
      status: :grand_parent,
      age: 68,
      parents: []
    }

    bridget = %{
      name: "Bridget",
      status: :grand_parent,
      age: 70
    }

    ygraine = %{
      name: "Ygraine",
      status: :parent,
      age: 45,
      parents: [bob, bridget]
    }

    %{
      name: "Arthur",
      status: :child,
      age: 22,
      parents: [
        uther,
        ygraine
      ]
    }
  end
end
