defmodule PruebaQLWeb.Schema do
  use Absinthe.Schema
  import_types PruebaQLWeb.Schema.ContentTypes


  query do
      import_fields(:querys_links)
    end

  mutation do
       import_fields(:mutations_links)
     end

  subscription  do
       import_fields(:subscriptions_links)
  end
end
