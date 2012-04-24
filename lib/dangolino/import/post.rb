# encoding: utf-8

require "mustache"

class Post < Mustache

  self.template_path = File.dirname(Dir.pwd) + "/templates"
  
  def initialize(post, comments)
    @post = post
    @comments = comments
  end
  
  def post_content
    @post[:post_content]
  end

  def post_title
    @post[:post_title]
  end
  
  def post_date_published
    @post[:post_date_published]
  end  
  
  def generated_at
    DateTime.now.strftime("%d/%m/%Y - %H:%M:%S")
  end
  
  def comments
    post_comments = nil  
    @comments.each{|c| 
      author = ""
      if (c[:comment_author_url] == "") 
        author =  "<dt>#{c[:comment_author]} comentou em #{c[:comment_date]}</dt>"
      else
        author =  "<dt><a href=\"#{c[:comment_author_url]}\">#{c[:comment_author]}</a> comentou em #{c[:comment_date]}</dt>"
      end
      
      comment_block = <<COMMENTS_BLOCK
            <dl>
            <dt>#{author}
            <dd>#{c[:comment_content]}</dd>
            </dl>
COMMENTS_BLOCK
      post_comments = "#{post_comments}#{comment_block}"
    }
    post_comments

  end
end