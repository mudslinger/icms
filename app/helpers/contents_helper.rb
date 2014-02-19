#coding:utf-8
require 'rss'
module ContentsHelper
  
  include CustomHelper #サイトに固有のヘルパ
  
  def each_headline(name, per_page = 5, options = {})
    per_page = per_page == :all ? 999 : per_page
    #logger.debug("each_headline(#{name})が呼ばれた")
    
    elements = headline(name,per_page, options) 
    if block_given?
    #cache "headline_#{name}" do
     # logger.debug("cacheブロックの中")
      elements.each do |entry|
        
        yield entry
      end
    #end
    else
       return elements
    end
  end
  

 #
 #カテゴリの件数を表示
 #
 def contents_count(name, per_page = 5, options = {})
   headline(name,per_page, options).total_count
 end
 
 #カスタムフィールドで並び替え
=begin
sql="
select 
entries.*,
entry_metas.string_value 
from entries, forms, fields, entry_metas 
where 
forms.template_name='akiya_bank' and forms.id=entries.form_id and 
forms.id=fields.form_id and fields.name='no' and 
entries.id=entry_metas.entry_id and 
entry_metas.field_id=fields.id 
order by entry_metas.string_value
"
Entry.find_by_sql sql  
=end
  
  
  def contents_detail_path_for(entry)
    contents_detail_path(:name => entry.form.template_name, :id => entry.id)
  end
  
  #特定のフィールドでソートする。
  #数値とみなす
  def nsort_by(entries, fname)
    entries.sort_by{|ele| 
      value = ele._cf(fname)
      value.tr('０-９', '0-9').to_i
    }
  end


  def ln2br(str)
    unless str.blank?
      str = ERB::Util.html_escape(str).gsub(/\r\n/, "\n")
      str.gsub("\n", "<br/>")
    end
  end
  
  #
  #
  #カスタムフィールドの値によってグループ化
  #
  def group_by(entries, fieldname )
    
    hs = Hash.new{|hash,key| hash[key] = [] }
    entries.each{|entry|
      value = entry._cf(fieldname)
      hs[value] << entry
    }
    hs
  end
  
  def group_by2(entries, fieldname )
    
    hs = Hash.new{|hash,key| hash[key] = [] }
    entries.each{|entry|
      value = entry[fieldname]
      hs[value] << entry
    }
    hs
  end
  
  #
  #RSS
  #
  def each_headline_rss(rss_source, count)
    cache "headline_rss" do
      rss = nil
      begin
        rss = RSS::Parser.parse(rss_source)
      rescue RSS::InvalidRSSError
        rss = RSS::Parser.parse(rss_source, false)
      end
      
      #rss.items.sort_by{ |i| i.date  }.reverse[0 .. 6].each do |item|
      rss.items[0 .. count - 1].each do |item|
        #puts item.date
        #puts "#{item.title} : #{item.date.strftime('%Y-%m-%d')}"
        yield item
      end
      
    end
  end
  
  #
  #公開からn日間、newという画像を表示する
  #
  def new_image_tag(entry, days, image_path = "new.gif")
    if entry
      date_to_compare = entry.date_begin
      date_to_compare ||= entry.created_at
      
      if days.days.since(date_to_compare) >= Time.now
        image_tag image_path
      end
    end
  end
  
  #
  #記事IDを指定して取得する
  #
  def entry_by_id(id)
    Entry.where_valid_article.where(:id => id).first    
  end
  
end
