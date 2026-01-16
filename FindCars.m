function FindCars()
% read the image files - assuming they are in the same directory
    car_double = im2double(imread("Cars.png"));
    car = imread("Cars.png");
    temp_car = imread("Template_Car.png");
    
% PART A: Locate the single best matching car and print out coordinates
% resize image temp_car to be smaller so its same size as cars in car
    temp_car_resize = imresize(temp_car, 0.7);
    
% convert the images to greyscale
    cargs = im2gray(car);
    temp_cargs = im2gray(temp_car_resize);
    
% NCC (Normalized Cross Correlation) Calculation
    ncc = normxcorr2(temp_cargs, cargs);
    
% find peak correlation - gives us location of match
    [y, x] = find(ncc == max(ncc(:)));
    
% reposition location for rectangle drawing
% subtract template size to get top-left corner coordinates
    y_new = y - size(temp_cargs, 1);
    x_new = x - size(temp_cargs, 2);
    
% print out match location
    fprintf('Part (a) Coordinates of match location: (%d, %d)\n', x_new, y_new);
    
% display rectangle and coordinates around the best match
    figure;
    imshow(car);
    hold on;
    % draw red rectangle around the matched car
    rectangle('Position',[x_new, y_new, size(temp_cargs, 2), size(temp_cargs, 1)],'EdgeColor','r', 'LineWidth', 3);

    % display coordinates as text above the rectangle
    text(x_new, y_new-5, sprintf('[%d,%d]', x_new, y_new), ...
        'Color', 'r', 'FontSize', 10, 'FontWeight', 'bold', 'BackgroundColor', 'k');    
    hold off;
    
% PART B: Locate most similar cars of the same color
% extract rgb color of template car (coordinates point to car roof)
    temp_car_color = squeeze(temp_car_resize(150,60,:));
    
% target is the value of color in double format (normalized to 0-1 range)
    target = [double(temp_car_color(1)) double(temp_car_color(2)) double(temp_car_color(3))] / 255;
    
% uses euclidean distance (difference of squares) to find pixels with closest color values
    diff = sqrt( (car_double(:,:,1) - target(1)).^2 + ...
                 (car_double(:,:,2) - target(2)).^2 + ...
                 (car_double(:,:,3) - target(3)).^2 );
    
% sets the threshold for which color matches are close enough (within 0.10 euclidean distance)
    mask = diff < 0.10;
    
% stores the x,y coordinates of all color-matching pixels
    [y_color_match, x_color_match] = find(mask);
    
% Cluster matching pixels and draw rectangles around detected cars
    if ~isempty(x_color_match)
        % uses dbscan clustering to group nearby matching pixels (epsilon=20, minPts=10)
        idx = dbscan([x_color_match, y_color_match], 20, 10);
        
        % removes noise points (idx=-1) and gets unique cluster IDs
        clusters = unique(idx(idx > 0));
        sizes = zeros(length(clusters), 1);
        bounds = zeros(length(clusters), 4);
        
        % loop through each cluster to calculate bounding boxes
        for i = 1:length(clusters)
            % get all points belonging to current cluster
            mask = (idx == clusters(i));
            cx = x_color_match(mask);
            cy = y_color_match(mask);
            
            % find bounding box coordinates
            xmin = min(cx);
            xmax = max(cx);
            ymin = min(cy);
            ymax = max(cy);
            
            % store bounds as [x, y, width, height]
            bounds(i,:) = [xmin, ymin, xmax-xmin+1, ymax-ymin+1];
            
            % store cluster size (number of pixels)
            sizes(i) = sum(mask);
        end
        
        % display image with bounding boxes
        figure; imshow(car_double); hold on;
        
        % sort clusters by size (largest first) and display top 5
        [~, sorted] = sort(sizes, 'descend');
        for i = sorted(1:min(5, length(sorted)))'
            % draw green rectangle around detected car
            rectangle('Position', bounds(i,:), 'EdgeColor', 'g', 'LineWidth', 2);
            % display coordinates as text above the rectangle
            text(bounds(i,1), bounds(i,2)-5, sprintf('[%d,%d]', bounds(i,1), bounds(i,2)), ...
                'Color', 'g', 'FontSize', 10, 'FontWeight', 'bold', 'BackgroundColor', 'k');
        end
        hold off;
    end
end