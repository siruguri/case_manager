class Role < ActiveRecord::Base
  # TODO This should be in the database

  @role_hierarchy = ['superadmin', 'admin', 'manager', 'volunteer']

  def self.supersedes(a, b)
    # does a supersede b?
    if @role_hierarchy.include? a.name and @role_hierarchy.include? b.name
      @role_hierarchy.index(a.name) <= @role_hierarchy.index(b.name)
    else
      false
    end
  end
end
