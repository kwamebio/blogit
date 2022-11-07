module BlogsHelper
    def blog_list_heading
        blog_type = case controller.action_name
          when "index" then "frontpage blog"
          when "bin" then "upcoming blog"
          end
        "showing #{ pluralize(@stories.size, story_type) }"
    end
    
end
