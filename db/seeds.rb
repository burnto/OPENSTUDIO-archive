# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require 'find'
require File.join(File.dirname(__FILE__), "..", "config", "environment.rb")

# Load meta
OS_DATA_DIR = File.join(RAILS_ROOT, "..", "openstudio.data")
META_DATA_DIR = File.join(OS_DATA_DIR, "meta")


Find.find(META_DATA_DIR) do |path|
  unless FileTest.directory?(path)

    legacy_id = File.basename(path, ".meta")
    File.open(path, 'r') do |f| 
      attributes = f.readlines.inject({}) do |memo,line|
        field, value = line.split(/\s+/, 2)
        field = field.chop
        memo.merge(field => value.strip)
      end
      p = Piece.new(:legacy_id => legacy_id, :title => attributes["title"])
      %w(created modified).each do |field|
        p.write_attribute("#{field}_at".to_sym, Time.parse(attributes[field]))
      end
      %w(owner creator).each do |field|
        params = attributes[field].split(/\s+\/\s+/)
        member = Member.find_or_initialize_by_login(params.first)
        if member.new_record?
          member.name = params[1]
          member.email = params[2]
          member.save!
        end
        p.write_attribute("#{field}_id".to_sym, member.id)
      end
      p.save!
    end
  end
end
  #   if FileTest.directory?(path)
  #     if File.basename(path)[0] == ?.
  #       Find.prune       # Don't look any further into this directory.
  #     else
  #       next
  #     end
  #   else
  #     total_size += FileTest.size(path)
  #   end
  # end
