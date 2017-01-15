defmodule Edu.Router do
  use Edu.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Edu do
    pipe_through :api

    resources "/groups", GroupController, except: [:new, :edit] do
      resources "/mentors", MentorController, except: [:new, :edit]
      resources "/students", StudentController, except: [:new, :edit]
    end

    resources "/coordinators", CoordinatorController, except: [:new, :edit]
    resources "/courses", CourseController, except: [:new, :edit]
    resources "/locations", LocationController, except: [:new, :edit]
    resources "/regions", RegionController, except: [:new, :edit]
    resources "/sessions", SessionController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end
end
