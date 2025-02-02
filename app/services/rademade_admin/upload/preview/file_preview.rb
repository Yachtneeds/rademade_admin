# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class Preview
      class FilePreview < RademadeAdmin::Upload::Preview

        include ActionView::Helpers::NumberHelper

        def initialize(uploader)
          @uploader = uploader
        end

        def preview_html(options = {})
          content_tag(:div, uploaded_file_html(options), :data => { :preview_item => '' })
        end

        def uploaded_file_html(options = {})
          if @uploader.blank? || @uploader.size.zero?
            ''
          else
            html_elements = [uploaded_preview_html]
            html_elements << remove_ico_html if options[:destroyable]
            content_tag(:div, HtmlBuffer.new(html_elements))
          end
        end

        def image?
          @uploader.class.ancestors.include? RademadeAdmin::Uploader::Photo
        end

        def video?
          @uploader.class.ancestors.include? RademadeAdmin::Uploader::Video
        end

        def crop?
          @uploader.class.ancestors.include? RademadeAdmin::Uploader::CropPhoto
        end

        def image_preview
          if image?
            @uploader.resize_with_crop(300, 300)
          else
            @uploader.url
          end
        end

        protected

        def uploaded_preview_html
          if image? || @uploader.file.content_type.match(/image\//)
            image_preview_html
          elsif video?
            video_preview_html
          else
            file_preview_html
          end
        end

        def image_preview_html
          content_tag(:img, '', {
            :src => image_preview,
            :data => image_data(@uploader).merge(
              :image_preview => ''
            )
          })
        end

        def video_preview_html
          content_tag(:a, content_tag(:img, '', :src => @uploader.thumb_path), download_params)
        end

        def file_preview_html
          file_path = @uploader.path
          file_name_parts = [::File.basename(file_path)]
          file_name_parts << number_to_human_size(::File.size(file_path)) rescue nil
          content_tag(:a, file_name_parts.join(', '), download_params)
        end

        def crop_url
          rademade_admin_route(:file_crop_url)
        end

        def download_params
          {
            :href => @uploader.url,
            :download => ''
          }
        end

        def remove_ico_html
          content_tag(:i, '', :class => 'upload-delete')
        end

      end
    end
  end
end
