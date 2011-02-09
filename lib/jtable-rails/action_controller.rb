module JTable
  module ActionController
    def jtable_for_json(rel, jtable_params)
      jtable_params = HashWithIndifferentAccess.new(jtable_params)
      {:total_items => rel.count, :items => rel.jtable_paginate(jtable_params[:limit], jtable_params[:offset])}
    end
  end
end