function processing()
    clc;
    clear all;
    %# create tabs for image, audio and video
     global fullchosenfile;
     global transformedImage;
     global originalImage;
     global loadedImage;
    scrsz = get(groot,'ScreenSize');
    %hFig = figure('Name', 'iProcessing', 'Menubar','none','OuterPosition', [1 (scrsz(3)*0.30) scrsz(3)*0.80 scrsz(4)*0.80]);
    hFig = figure('Name', 'iProcessing', 'Menubar','none','Position', [100, 80, scrsz(4)*1.5, scrsz(4)*0.83]);
    
    s = warning('off', 'MATLAB:uitabgroup:OldVersion');
    hTabGroup = uitabgroup('Parent',hFig);
    warning(s);
    
    %create tabs
    hTabs(1) = uitab('Parent',hTabGroup, 'Title','Image');    
    hTabs(2) = uitab('Parent',hTabGroup, 'Title','About');
    set(hTabGroup, 'SelectedTab',hTabs(1));

    %# populate tabs with UI components
    
   %Construct the components for Tab 1 => Image
   mainPanel = uipanel('Title','','FontSize',12,...
             'BackgroundColor','white',...
             'Parent',hTabs(1),...
             'Position',[0 0 1 1]);
   aboutPanel = uipanel('Title','','FontSize',12,...
             'Parent',hTabs(2),...
             'Position',[0 0 1 1]);
   about_text = uicontrol('Style','text',...
             'Units','normalized',...
             'FontSize',12,...
             'String', {'This software is developed by Ganesh R Zilpe.';''; 'It is created using the knowledge of different blogs available on the ';'Internet. At few places, I have used the code posted on MathWorks website, ';'http://blogs.mathworks.com/steve/2012/11/13/image-effects-part-1/ ';'and on other websites';' ';'Please let me know if there are any improvements possible. You can reach me at zilpeganesh@gmail.com'},...
             'Parent',aboutPanel,...
             'Position',[0.1 0.1 .9 .9]);
         
   %button Panel
   settingPanel = uipanel('Parent',mainPanel,'Title','Settings','FontSize',10,...
              'Position',[0 .7 1 .3]);
    
   %Load Image button
   hload = uicontrol('Style','pushbutton',...
           'String','Load Image',...
           'Units','normalized',...
           'FontSize',9,...
           'Parent',settingPanel,...
           'Position',[0.25 0.8 0.15 0.2 ]);
       
   set(hload,'callback',{@loadButtonCallback})  % Set the callback for pushbutton.
   %Reset button
   hreset = uicontrol('Style','pushbutton',...
           'String','Reset',...
           'Units','normalized',...
            'FontSize',9,...
           'Parent',settingPanel,...
           'Position',[0.45 0.8 0.15 0.2 ]);
  set(hreset,'callback',{@resetButtonCallback})  % Set the callback for pushbutton.
 
   %Export button
   hexport = uicontrol('Style','pushbutton',...
           'String','Export',...
           'Units','normalized',...
            'FontSize',9,...
           'Parent',settingPanel,...
           'Position',[0.65 0.8 0.15 0.2 ]); 
   set(hexport,'callback',{@exportButtonCallback})  % Set the callback for pushbutton.   
   set(hexport,'Enable','off');
   %Crop setting pannel
   cropButtonPanel = uipanel('Parent',settingPanel,...
            'Title','Crop',...
            'FontSize',10,...
            'Position',[0 0 .1 .79]);
    %Square Crop button
  hscrop = uicontrol('Style','pushbutton',...
           'String','Sqaure',...
           'Units','normalized',...
            'FontSize',9,...
           'Parent',cropButtonPanel,...
           'Position',[0.1 0.6 .75 0.3 ]); 
   set(hscrop,'callback',{@sqaureCropButtonCallback})  % Set the callback for pushbutton.
   
   %Circular Crop button
   hccrop = uicontrol('Style','pushbutton',...
           'String','Circular',...
           'Units','normalized',...
            'FontSize',9,...
           'Parent',cropButtonPanel,...
           'Position',[0.1 0.2 .75 0.3 ]); 
   set(hccrop,'callback',{@circularCropButtonCallback})  % Set the callback for pushbutton.
   
   
   
        
   %Shape settings button group
   shapeButtonGroup = uibuttongroup('Parent',settingPanel,...
            'Title','Shapes',...
            'FontSize',10,...
            'Position',[0.11 0 .2 .79],...
            'SelectionChangedFcn',@shape_selection);
   
   rb_original = uicontrol(shapeButtonGroup,'Style','radiobutton',...
            'String','Original',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.02 .7 .45 .2]);
   rb_square = uicontrol(shapeButtonGroup,'Style','radiobutton',...
            'String','Square',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.5 .7 .45 .2]);
   rb_rectangle = uicontrol(shapeButtonGroup,'Style','radiobutton',...
            'String','Rectangle',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.02 .4 .45 .2]);
    rb_circle = uicontrol(shapeButtonGroup,'Style','radiobutton',...
            'String','Circular',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.5 .4 .45 .2]);
%     rb_oval = uicontrol(shapeButtonGroup,'Style','radiobutton',...
%             'String','Oval',...
%             'Units','normalized',...
%             'FontSize',9,...
%             'Position',[0.02 .1 .45 .2]);
%     rb_rectangle = uicontrol(shapeButtonGroup,'Style','radiobutton',...
%             'String','Rectangle',...
%             'Units','normalized',...
%             'FontSize',9,...
%             'Position',[0.5 .1 .45 .2]);
        
        
        
    %Effects settings button group
   effectsButtonGroup = uibuttongroup('Parent',settingPanel,...
            'Title','Effects',...
            'FontSize',10,...
            'Position',[0.32 0 .52 .79],...
             'SelectionChangedFcn',@effects_selection);
   % 1.original
   rb_originale = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Original',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.02 .7 .23 .2]);
   % 2. Safari 1
   rb_safari1 = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Safari 1',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.26 .7 .23 .2]);
   % 3. Safari 2
   rb_safari2 = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Safari 2',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.5 .7 .23 .2]);
   % 4. Stand Out
   rb_gray = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','GrayScale',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.74 .7 .23 .2]);
    % 5. Enhanced
    rb_enhanced = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Enhanced',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.02 .4 .23 .2]);
    % 6. Effect 1
    rb_effect1 = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Effect 1',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.26 .4 .23 .2]);
    % 7. Effect 2
    rb_effect2 = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Effect 2',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.5 .4 .23 .2]);
   % 8. Effect 3
   rb_bnw = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Black n White',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.74 .4 .23 .2]);
    % 9. Contrast
    rb_contrast = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Contrast Enhanced',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.02 .1 .26 .2]);
    % 10. Decorrelation
    rb_decorrelation = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Decorrelation',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.26 .1 .23 .2]);
    % 11. Reverse
    rb_reverse = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Reverse',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.5 .1 .23 .2]);
     % 12. Reverse
    rb_effect4 = uicontrol(effectsButtonGroup,'Style','radiobutton',...
            'String','Effect 4',...
            'Units','normalized',...
            'FontSize',9,...
            'Position',[0.74 .1 .23 .2]);
    
        
    %resize panel
    resizePanel = uipanel('Parent',settingPanel,...
            'Title','Resize',...
            'FontSize',10,...
            'Position',[0.85 0 .14 .79]);
    %height label of resize panel
    l_height = uicontrol('Style','text',...
            'Units','normalized',...
            'Parent',resizePanel,...
            'String','Height(%)',...
            'FontSize',9,...
            'position',[.01 .7 .6 .2]);
        
    % height textbox of resize panel  
    txtbox_height = uicontrol('style','edit',...
            'Units','normalized',...
            'Parent',resizePanel,...
            'foregroundcolor','b',...
            'Position',[0.61 .7 .35 .2],...
            'callback',{@resize_checknumber});
        
        
    %width label of resize panel
    l_width = uicontrol('Style','text',...
            'Units','normalized',...         
            'FontSize',9,...
            'Parent',resizePanel,...
            'string','Width(%)',...
            'position',[.01 .4 .6 .2]);
    
    % height textbox of resize panel  
    txtbox_width = uicontrol('style','edit',...
            'Units','normalized',...
            'Parent',resizePanel,...
            'foregroundcolor','b',...
            'Position',[0.61 .4 .35 .2],...
            'callback',{@resize_checknumber});
        
    %Apply button of Resize Panel
    button_apply = uicontrol('Style','pushbutton',...
           'String','Apply',...
           'Units','normalized',...
            'FontSize',9,...
           'Parent',resizePanel,...
           'Position',[0.35 0.05 0.3 0.3 ]); 
   set(button_apply,'callback',{@resizeCallback})  % Set the callback for pushbutton.
        
        
        
   %original image panel
   originalPanel = uipanel('Parent',mainPanel,'Title','Original Image','FontSize',10,...
              'Position',[0 0 0.495 0.69]);
   
   %Frame for original image
   originalImageFrame = axes('Parent',originalPanel,...
       'Position',[0.05, 0.05, 0.9 0.9]); 
   set(originalImageFrame, 'xtick',[],'ytick',[], 'XTickLabelMode', 'manual', 'XTickLabel', []);
   set(originalImageFrame, 'xtick',[],'ytick',[], 'YTickLabelMode', 'manual', 'YTickLabel', []);
   
   
   %transformed image panel
   morphedPanel = uipanel('Parent',mainPanel,'Title','Transformed Image','FontSize',10,...
              'Position',[0.505 0 0.495 0.69]);
          
   hbackToOriginal = uicontrol('Style','pushbutton',...
           'String','Use image as Original',...
           'Units','normalized',...
            'FontSize',9,...
           'Parent',morphedPanel,...
           'Position',[0.67 0.912 0.3 0.09]); 
   set(hbackToOriginal,'callback',{@useAsOriginalButtonCallback})  % Set the callback for pushbutton.
   set(hbackToOriginal,'Enable','off');
   
    %Frame for original image
   morphedImageFrame = axes('Parent',morphedPanel,...
       'Position',[0.05, 0.05, 0.9 0.85]); 
   set(morphedImageFrame, 'xtick',[],'ytick',[], 'XTickLabelMode', 'manual', 'XTickLabel', []);
   set(morphedImageFrame, 'xtick',[],'ytick',[], 'YTickLabelMode', 'manual', 'YTickLabel', []);
     
   
        
    function loadButtonCallback(src,evt)
        %# load data
        [fName,pName] = uigetfile({'*.jpg';'*.png';}, 'Select an image');
        if pName == 0, return; end
        fullchosenfile = [pName, fName];
        imagedata = imread(fullchosenfile);
        imshow(imagedata, 'Parent', originalImageFrame);
        transformedImage = imagedata;
        originalImage = imagedata;
        loadedImage = imagedata;
        if ~isempty(morphedImageFrame)
            axesHandlesToChildObjects = findobj(morphedImageFrame, 'Type', 'image');
            delete(axesHandlesToChildObjects);
        end
        set(hexport,'Enable','off');
        set(hbackToOriginal,'Enable','off');
    end

    
    
    function resetButtonCallback(src,evt)
        %# load data  
        if ~isempty(morphedImageFrame)
            axesHandlesToChildObjects = findobj(morphedImageFrame, 'Type', 'image');
            delete(axesHandlesToChildObjects);
        end
        imshow(loadedImage, 'Parent', originalImageFrame);
        originalImage = loadedImage;
        set(hexport,'Enable','off');
        set(hbackToOriginal,'Enable','off');
    end

    function exportButtonCallback(src,evt)
        %# export transformed image
        if fullchosenfile == 0, return; end
        [filename, pathname] = uiputfile({'*.jpg'; '*.png'; '*.jpeg'}, 'Save image as');
        if isequal(filename,0) || isequal(pathname,0)
           disp('User selected Cancel')
           return;
        else
           disp(['User selected ',fullfile(pathname,filename)])
           imwrite(transformedImage, fullfile(pathname,filename));
           msgbox('Image is exported successfully','Message');
        end
    end


    function sqaureCropButtonCallback(src,evt)
        %# load data
        if fullchosenfile == 0, return; end
        imagedata = originalImage;
        rect=getrect;                           % select rectangle
        croppedImg=imcrop(imagedata,rect);                      % crop
        imshow(croppedImg, 'Parent', morphedImageFrame);
        transformedImage = croppedImg;
        set(hexport,'Enable','on');
        set(hbackToOriginal,'Enable','on');
    end

    function circularCropButtonCallback(src,evt)
        %# load data
        if fullchosenfile == 0, return; end
        imagedata = originalImage;
        rect=getrect;                           % select rectangle
        croppedImg=imcrop(imagedata,rect);                      % crop
         u = size(croppedImg);
                    mx = ceil(u(2)/2);
                    my = ceil(u(1)/2);
                    if mx<my
                        my=mx;
                    else
                        mx=my;
                    end
                    if (length(u)==3),
                        for x=1:u(2),
                            for y=1:u(1),
                                if (x-mx)^2 + (y-my)^2 > mx^2,
                                    croppedImg(y,x,1) = 0;
                                    croppedImg(y,x,2) = 0;
                                    croppedImg(y,x,3) = 0;
                                end
                            end
                        end
                    else,
                        for x=1:u(2),
                            for y=1:u(1),
                                if (x-mx)^2 + (y-my)^2 > mx^2,
                                    croppedImg(y,x) = 0;
                                end
                            end
                        end
                    end
                imshow(croppedImg, 'Parent', morphedImageFrame);
                transformedImage = croppedImg;
                set(hexport,'Enable','on');
                set(hbackToOriginal,'Enable','on');
    end

    function shape_selection(source,callbackdata)
        display(['Previous: ' callbackdata.OldValue.String]);
        display(['Current: ' callbackdata.NewValue.String]);
        display('------------------');
        if fullchosenfile == 0, return; end
        imagedata = originalImage;
         display('Current: success');
        switch callbackdata.NewValue.String
            case 'Circular'
                 u = size(imagedata);
                    mx = ceil(u(2)/2);
                    my = ceil(u(1)/2);
                    if mx<my
                        my=mx;
                    else
                        mx=my;
                    end
                    if (length(u)==3),
                        for x=1:u(2),
                            for y=1:u(1),
                                if (x-mx)^2 + (y-my)^2 > mx^2,
                                    imagedata(y,x,1) = 0;
                                    imagedata(y,x,2) = 0;
                                    imagedata(y,x,3) = 0;
                                end
                            end
                        end
                    else,
                        for x=1:u(2),
                            for y=1:u(1),
                                if (x-mx)^2 + (y-my)^2 > mx^2,
                                    imagedata(y,x) = 0;
                                end
                            end
                        end
                    end
                imshow(imagedata, 'Parent', morphedImageFrame);
                transformedImage = imagedata;
            case 'Square'
%                 A=double(imagedata);
%                 B = A/max(A(:));
%                 [crop rect] = imcrop(B); % interactively crop
%                 rect
%                  if rect(3) ~= rect(4) % not square
%                     c = rect(1:2) + .5*rect(3:4); % center
%                     w = min( rect(3:4) ); % take min dimension
%                     rect = [ ceil(c-.5*[w w]), w, w ];
%                     crop = imcrop( B, rect ); % re-crop
%                  end 
                sz = min([size(imagedata, 1) size(imagedata, 2)]);
                transformedImage = imresize(imagedata, [sz sz]);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Rectangle'
                sz = min([size(imagedata, 1) size(imagedata, 2)]);
                transformedImage = imresize(imagedata, [sz (sz.*1.5)]);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Original'
                imshow(imagedata, 'Parent', morphedImageFrame);
            otherwise
               imshow(imagedata, 'Parent', morphedImageFrame);
        end
        set(hexport,'Enable','on');
        set(hbackToOriginal,'Enable','on');
    end

    % Effects
    function effects_selection(source,callbackdata)
        display(['Previous: ' callbackdata.OldValue.String]);
        display(['Current: ' callbackdata.NewValue.String]);
        display('------------------');
        if fullchosenfile == 0, return; end
        imagedata = originalImage;
         display('Current: success');
        switch callbackdata.NewValue.String
            case 'Safari 1'
                enhanced = entropyfilt(originalImage,getnhood(strel('disk',1)));
                enhanced = enhanced/max(enhanced(:));
                enhanced = imadjust(enhanced,stretchlim(enhanced));
                imshow(enhanced, 'Parent', morphedImageFrame);
                transformedImage = enhanced;
            case 'Safari 2'
                imgEnhanced = entropyfilt(originalImage,getnhood(strel('Disk',4)));
                imgEnhanced = imgEnhanced/max(imgEnhanced(:));
                imgEnhanced = imadjust(imgEnhanced,[0.30; 0.85],[0.90; 0.00], 0.90);
                imshow(imgEnhanced, 'Parent', morphedImageFrame);
                transformedImage = imgEnhanced;
            case 'Enhanced'
                transformedImage = imadjust(originalImage,[0.00; 0.35],[0.00; 1.00], 1.00);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Reverse'
                transformedImage = imadjust(originalImage,[0.00; 1.00],[1.00; 0.00], 1.00);
                img2 = imcomplement(originalImage);
                assert(isequal(transformedImage,img2));
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Contrast-Enhanced'
                SE = strel('Disk',18);
                transformedImage = imsubtract(imadd(originalImage,imtophat(originalImage,SE)),imbothat(originalImage,SE));
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Effect 1'
                SE = strel('Disk',18);
                imgEnhanced = imsubtract(imadd(originalImage,imtophat(originalImage,SE)),imbothat(originalImage,SE));
                transformedImage = imadjust(imgEnhanced,[0.13 0.00 0.30; 0.75 1.00 1.00],[0.00 1.00 0.50; 1.00 0.00 0.27], [5.90 0.80 4.10]);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Effect 2'
                SE = strel('Disk',18);
                imgEnhanced = imsubtract(imadd(originalImage,imtophat(originalImage,SE)),imbothat(originalImage,SE));
                transformedImage = imadjust(imgEnhanced,[0.00 0.00 0.00; 1.00 0.38 0.40],[1.00 0.00 0.70; 0.20 1.00 0.40], [4.90 4.00 1.70]);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Decorrelation'
                transformedImage = decorrstretch(originalImage);
                transformedImage = imadjust(transformedImage,[0.10; 0.79],[0.00; 1.00], 1.10);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'GrayScale'
                transformedImage = rgb2hsv(originalImage);
                transformedImage = transformedImage(:,:,2);
                transformedImage =  imadjust(transformedImage,[0.6; 1.0],[0.00; 1.00], 1.00);
                imshow(transformedImage, 'Parent', morphedImageFrame);
            case 'Black n White'
                grayImg = rgb2hsv(originalImage);
                grayImg = grayImg(:,:,2);
                grayImg =  imadjust(grayImg,[0.6; 1.0],[0.00; 1.00], 1.00);
                transformedImage = im2bw(grayImg,graythresh(grayImg));
                imshow(transformedImage, 'Parent', morphedImageFrame);
                
            otherwise
               imshow(imagedata, 'Parent', morphedImageFrame);
        end
        set(hexport,'Enable','on');
        set(hbackToOriginal,'Enable','on');
    end



    function useAsOriginalButtonCallback(~,evt)
        %# set tranformed image as Original image
        originalImage = transformedImage;
        imshow(transformedImage, 'Parent', originalImageFrame);
    end

    % on Apply button of Resize panel, resize the original image
    function resize_checknumber(src,eventdata)
        str=get(src,'String');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
    end

    function resizeCallback(src,eventdata)
       [height_x, width_x] = size(originalImage);
       input_height = get(txtbox_height, 'String');
       input_width = get(txtbox_width, 'String');
       if isempty(str2num(input_height))
            set(src,'string','0');
            warndlg('Input must be numerical');
            return;
       end
       if isempty(str2num(input_width))
            set(src,'string','0');
            warndlg('Input must be numerical');
            return;
       end
       aspect_height = input_height .* height_x;
       aspect_height = ceil(aspect_height(1) ./ 100);
       %height_x
       %input_height
       %aspect_height
       aspect_width = ceil((width_x(1) ./100) .* input_width);
       %width_x
       %input_width
       %aspect_width(1)
       transformedImage = imresize(originalImage, [aspect_height(1) aspect_width(1)]);
       imshow(transformedImage, 'Parent', morphedImageFrame);
       set(hexport,'Enable','on');
       set(hbackToOriginal,'Enable','on');
    end


    %# drop-down menu callback
    function popupCallback(src,evt)
        %# update plot color
        val = get(src,'Value');
        clr = {'r' 'g' 'b'};
        set(hLine, 'Color',clr{val})

        %# swithc to plot tab
        set(hTabGroup, 'SelectedTab',hTabs(3));
        drawnow
    end
end