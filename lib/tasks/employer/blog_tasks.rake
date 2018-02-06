Bundler.require(:default, Rails.env)

namespace :employer do
  namespace :blog do
    desc 'Seed Employer Blog ContentType and Fields'
    task seed: :environment do
      example_tenant = Cortex::Tenant.find_by_name('Example')

      def research_tree
        tree = Tree.new
        tree.add_node({name: "CB Research"})
        tree.add_node({name: "Third Party Research"})

        tree
      end

      def category_tree
        tree = Tree.new
        tree.add_node({ name: "Product News" })
        tree.add_node({ name: "Company News, Research and Trends" })
        tree.add_node({ name: "Client Success Stories" })
        tree.add_node({ name: "Recruiting Solutions" })
        tree.add_node({ name: "Employment Screening" })
        tree.add_node({ name: "Human Capital Management" })

        tree
      end

      def persona_tree
        tree = Tree.new
        tree.add_node({name: "General Audience"})
        tree.add_node({name: "Recruiters"})
        tree.add_node({name: "Sourcers"})
        tree.add_node({name: "Managers/Directors"})
        tree.add_node({name: "C-Level"})

        tree
      end

      puts "Creating Employer Blog ContentType..."
      blog = Cortex::ContentType.new({
                               name: "Employer Blog",
                               name_id: "employer_blog",
                               description: "Blog for Employer",
                               icon: "description",
                               tenant: example_tenant,
                               creator: Cortex::User.first,
                               contract: Cortex::Contract.first, # TODO: This is obviously bad. This whole file is bad.
                               publishable: true
                             })
      blog.save!

      puts "Creating Fields..."
      blog.fields.new(name: 'Body', name_id: 'body', field_type: 'text_field_type', metadata: {parse_widgets: true}, validations: { presence: true, length: { minimum: 50} })
      blog.fields.new(name: 'Title', name_id: 'title', field_type: 'text_field_type', validations: {presence: true, length: { maximum: 100 } })
      blog.fields.new(name: 'Description', name_id: 'description', field_type: 'text_field_type', validations: {presence: true, length: { maximum: 200, minimum: 50} })
      blog.fields.new(name: 'Slug', name_id: 'slug', field_type: 'text_field_type', validations: {presence: true, uniqueness: true, length: { maximum: 75 } })
      blog.fields.new(name: 'Author', name_id: 'author', field_type: 'author_field_type')
      blog.fields.new(name: 'Tags', name_id: 'tags', field_type: 'tag_field_type')
      blog.fields.new(name: 'Publish Date', name_id: 'publish_date', field_type: 'date_time_field_type', metadata: {state: 'Published'})
      blog.fields.new(name: 'Expiration Date', name_id: 'expiration_date', field_type: 'date_time_field_type', metadata: {state: 'Expired'})
      blog.fields.new(name: 'SEO Title', name_id: 'seo_title', field_type: 'text_field_type', validations: {presence: true, length: {maximum: 70}, uniqueness: true })
      blog.fields.new(name: 'SEO Description', name_id: 'seo_description', field_type: 'text_field_type', validations: {presence: true, length: {maximum: 160} })
      blog.fields.new(name: 'SEO Keywords', name_id: 'seo_keywords', field_type: 'tag_field_type')
      blog.fields.new(name: 'No Index', name_id: 'no_index', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Follow', name_id: 'no_follow', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Snippet', name_id: 'no_snippet', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No ODP', name_id: 'no_odp', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Archive', name_id: 'no_archive', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Image Index', name_id: 'no_image_index', field_type: 'boolean_field_type')
      blog.fields.new(name: 'Categories', name_id: 'categories', field_type: 'tree_field_type', metadata: {allowed_values: category_tree}, validations: {maximum: 2, minimum: 1})
      blog.fields.new(name: 'Research', name_id: 'research', field_type: 'tree_field_type', metadata: {allowed_values: research_tree}, validations: {minimum: 1})
      blog.fields.new(name: 'Persona', name_id: 'persona', field_type: 'tree_field_type', metadata: {allowed_values: persona_tree})
      blog.fields.new(name: 'Featured Image', name_id: 'featured_image', field_type: 'content_item_field_type',
                      metadata: {
                        field_name: 'Asset'
                      })

      puts "Saving Employer Blog..."
      blog.save!

      puts "Creating Wizard Cortex::Decorators..."
      wizard_hash = {
        "steps": [
          {
            "name": "Write",
            "heading": "First thing's first..",
            "description": "Author your post using Cortex's WYSIWYG editor.",
            "columns": [
              {
                "heading": "Writing Panel Sections's Optional Heading",
                "grid_width": 12,
                "display": {
                  "classes": [
                    "text--right"
                  ]
                },
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Title').id
                  },
                  {
                    "id": blog.fields.find_by_name('Body').id,
                    "render_method": "wysiwyg",
                    "input": {
                      "display": {
                        "styles": {
                          "height": "500px"
                        }
                      }
                    }
                  }
                ]
              }
            ]
          },

          {
            "name": "Details",
            "heading": "Let's talk about your post..",
            "description": "Provide details and metadata that will enhance search or inform end-users.",
            "columns": [
              {
                "heading": "Publishing (Optional Heading)",
                "grid_width": 6,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Description').id,
                    "tooltip": 'This is a short description and will be used as the preview text for a reader before they click into your full post.'
                  },
                  {
                    "id": blog.fields.find_by_name('Publish Date').id
                  },
                  {
                    "id": blog.fields.find_by_name('Expiration Date').id
                  }
                ]
              },
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Tags').id
                  },
                  {
                    "id": blog.fields.find_by_name('Slug').id,
                    "tooltip": "This is your post's URL. Between each word, place a hyphen. Best if between 35-50 characters and don't include years/dates."
                  },
                  {
                    "id": blog.fields.find_by_name('Author').id
                  }
                ]
              }
            ]
          },
          {
            "name": "Categorize",
            "heading": "Sort Into Categories..",
            "description": "Select the categories that best describe your post.",
            "columns": [
              {
                "heading": "Publishing (Optional Heading)",
                "grid_width": 4,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Categories').id,
                    "render_method": "checkboxes",
                    "tooltip": "Please select 1-2 Categories."
                  }
                ]
              },
              {
                "grid_width": 4,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Persona').id,
                    "render_method": "dropdown",
                    "tooltip": "If this is for a specific role or audience, please select. If it's for everyone, choose general audience."
                  }
                ]
              },
              {
                "grid_width": 4,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Research').id,
                    "render_method": "dropdown",
                    "tooltip": "If your post is based on research, please select if it's CB owned or created (including Emsi), or if we're reporting on someone else's data."
                  }
                ]
              }
            ]
          },
          {
            "name": "Add Featured Image",
            "description": "Add an image to feature with this Blog Post.",
            "columns": [
              {
                "heading": "Image (Optional Heading)",
                "grid_width": 12,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Featured Image').id,
                    "render_method": "popup"
                  }
                ]
              }
            ]
          },
          {
            "name": "Search",
            "heading": "How can others find your post..",
            "description": "Provide SEO metadata to help your post get found by your Users!",
            "columns": [
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('SEO Title').id,
                    "tooltip": 'Please use <70 characters for your SEO title for optimal appearance in search results.'
                  },
                  {
                    "id": blog.fields.find_by_name('SEO Description').id,
                    "tooltip": 'The description should optimally be between 150-160 characters and keyword rich.'
                  },
                  {
                    "id": blog.fields.find_by_name('SEO Keywords').id,
                    "tooltip": 'Utilize the recommended keywords as tags to boost your SEO performance.'
                  }
                ]
              },
              {
                "grid_width": 6,
                "description": "Select these if you don't want your post to be indexed by search engines like Google",
                "elements": [
                  {
                    "id": blog.fields.find_by_name('No Index').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Follow').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Snippet').id
                  },
                  {
                    "id": blog.fields.find_by_name('No ODP').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Archive').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Image Index').id
                  }
                ]
              }
            ]
          }
        ]
      }

      blog_wizard_decorator = Cortex::Decorator.new(name: "Wizard", data: wizard_hash, tenant: example_tenant)
      blog_wizard_decorator.save!

      Cortex::ContentableDecorator.create!({
                                    decorator_id: blog_wizard_decorator.id,
                                    contentable_id: blog.id,
                                    contentable_type: 'Cortex::ContentType',
                                    tenant: example_tenant
                                  })

      puts "Creating Index Cortex::Decorators..."
      index_hash = {
        "columns":
          [
            {
              "name": "Author",
              "grid_width": 2,
              "cells": [{
                          "field": {
                            "method": "creator.email"
                          },
                          "display": {
                            "classes": [
                              "circular"
                            ]
                          }
                        }]
            },
            {
              "name": "Post Details",
              "cells": [
                {
                  "field": {
                    "id": blog.fields.find_by_name('Title').id
                  },
                  "display": {
                    "classes": [
                      "bold",
                      "upcase"
                    ]
                  }
                },
                {
                  "field": {
                    "id": blog.fields.find_by_name('Slug').id
                  }
                },
                {
                  "field": {
                    "method": "publish_state"
                  }
                }
              ]
            },
            {
              "name": "Tags",
              "cells": [
                {
                  "field": {
                    "id": blog.fields.find_by_name('Tags').id
                  },
                  "display": {
                    "classes": [
                      "tag",
                      "rounded"
                    ]
                  }
                }
              ]
            }
          ]
      }

      blog_index_decorator = Cortex::Decorator.new(name: "Index", data: index_hash, tenant: example_tenant)
      blog_index_decorator.save!

      Cortex::ContentableDecorator.create!({
                                    decorator_id: blog_index_decorator.id,
                                    contentable_id: blog.id,
                                    contentable_type: 'Cortex::ContentType',
                                    tenant: example_tenant
                                  })

      puts "Creating RSS Cortex::Decorators..."
      rss_hash = {
        "channel": {
          "title": { "string": "Employer Blog" },
          "link": { "string": "http://resources.careerbuilder.com" },
          "description": { "string": "News and trends, best practices, product news and more from CareerBuilder's experts." },
          "language": { "string": "en-US" }
        },
        "item": {
          "title": { "field": blog.fields.find_by_name('Title').id },
          "description": { "field": blog.fields.find_by_name('Description').id },
          "link": { "method": {
                      "name": "rss_url",
                      "args": ["https://resources.careerbuilder.com/", blog.fields.find_by_name('Slug').id]
                   }
          },
          "pubDate": { "method": {
            "name": "rss_date",
            "args": [blog.fields.find_by_name('Publish Date').id]
            }
          },
          "author": { "method": {
            "name": "rss_author",
            "args": [blog.fields.find_by_name('Author').id]
            }
          },
          "category": { "transaction": {
            "name": "get_field_tree_list",
            "args": {field_id: blog.fields.find_by_name('Categories').id}
            }, "multiple": ","
          },
          "media:content": { "media":
            { "field": blog.fields.find_by_name('Featured Image').id,
              "medium": "image"
            }
          },
          "content": { "field": blog.fields.find_by_name('Body').id, "encode": true }
        }
      }

      blog_rss_decorator = Cortex::Decorator.new(name: "Rss", data: rss_hash, tenant: example_tenant)
      blog_rss_decorator.save!

      Cortex::ContentableDecorator.create!({
                                    decorator_id: blog_rss_decorator.id,
                                    contentable_id: blog.id,
                                    contentable_type: 'Cortex::ContentType',
                                    tenant: example_tenant
                                  })
    end
  end
end
