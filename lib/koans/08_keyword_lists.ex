defmodule KeywordLists do
  use Koans

  @intro "KeywordLists"

  koan "Like maps, keyword lists are key-value pairs" do
    kw_list = [foo: "bar"]

    assert kw_list[:foo] == "bar"
  end

  koan "Keys may be repeated, but only the first is accessed" do
    kw_list = [foo: "bar", foo: "baz"]

    assert kw_list[:foo] == "bar"
  end

  koan "You could access a second key by removing the first" do
    kw_list = [foo: "bar", foo: "baz"]
    [head|kw_list] = kw_list

    assert head == {:foo, "bar"}
    assert kw_list[:foo] == "baz"
  end

  koan "Keyword lists are just special syntax for lists of two-element tuples" do
    assert [foo: "bar"] == [{:foo, "bar"}]
  end

  koan "But unlike maps, the keys in keyword lists must be atoms" do
    not_kw_list = [{"foo", "bar"}]

    assert_raise ArgumentError, fn -> not_kw_list["foo"] end
  end

  koan "Conveniently keyword lists can be used for function options" do
    transform = fn
      str, [upcase: true] -> String.upcase(str)
      str, [upcase: false] -> str
    end

    assert transform.("good", upcase: true) == "GOOD"
    assert transform.("good", upcase: false) == "good"
  end
end
