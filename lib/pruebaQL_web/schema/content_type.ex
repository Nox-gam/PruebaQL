defmodule PruebaQLWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  alias PruebaQLWeb.Resolvers
  alias PruebaQLWeb.Topics

  object :link do
    field :id, :id
    field :url, :string
    field :description, :string
  end

  object :querys_links do
    @desc "query de obtención de todos los links"
    field :links, non_null(list_of(non_null(:link))) do
      resolve(&Resolvers.Content.list_links/3)
    end

      @desc "query de obtención de link en especifico"
      field :link_id, :link do
        arg :id, non_null(:id)
      resolve(&Resolvers.Content.get_link/3)
      end
  end

  object :mutations_links do
    @desc "crear link"
      field :create_link, :link do
       arg :url, non_null(:string)
       arg :description, non_null(:string)
       resolve &Resolvers.Content.create_link/3
      end

    @desc "actualizar descripción de un link"
      field :update_link, :link do
        arg :id, non_null(:id)
        arg :description, non_null(:string)
        resolve &Resolvers.Content.update_link/3
       end

      @desc "eliminar link"
       field :delete_link, :link do
        arg :id, non_null(:id)
        resolve &Resolvers.Content.delete_link/3
      end

  end

object :subscriptions_links do

    field :link_created, :link do

      config(fn _args, _info ->
        {:ok, topic: Topics.link_created()}
      end)

      trigger(:create_link,
      topic: fn _link_created ->
        Topics.link_created()
    end)

    resolve(fn link_created, _, _  -> {:ok, link_created}  end)
    end

    field :link_updated, :link do

      config(fn _args, _info ->
        {:ok, topic: Topics.link_updated()}
      end)

      trigger(:update_link,
      topic: fn _link_updated ->
        Topics.link_updated()
      end)

      resolve(fn link_updated, _, _ -> {:ok, link_updated} end)
    end

    field :link_deleted, :link do

      config(fn _args, _info ->
        {:ok, topic: Topics.link_deleted()}
      end)

      trigger(:delete_link,
      topic: fn _link_updated ->
        Topics.link_deleted()
      end)

      resolve(fn link_deleted, _, _ -> {:ok, link_deleted} end)
    end

  end


end
