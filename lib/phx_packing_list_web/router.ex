defmodule PhxPackingListWeb.Router do
  use PhxPackingListWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhxPackingListWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxPackingListWeb do
    pipe_through :browser

    get "/", PageController, :home

    resources "/v1", PackingListController do
     resources "/items", ItemController, only: [:index, :new, :create, :edit, :update, :delete]
    end

    live "/packing_lists", PackingListLive.Index, :index
    live "/packing_lists/new", PackingListLive.Index, :new
    live "/packing_lists/:id/edit", PackingListLive.Show, :edit

    live "/packing_lists/:id", PackingListLive.Show, :show
    live "/packing_lists/:id/show/edit", PackingListLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxPackingListWeb do
  #   pipe_through :api
  # end
end
