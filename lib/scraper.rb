require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page 
  data = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end 
  
  def get_courses
  self.get_page.css("article.post")
  end 
  
  def make_courses
  self.get_courses.map do |courses|
  course = Course.new 
  course.title = courses.css("article h2").text
  course.schedule = courses.css("article em.date").text
  course.description = courses.css("article p").text
  end 
end 
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



