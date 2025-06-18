clc; clear;

% === 설정 ===
base_path = 'C:\Users\user.DESKTOP-3NN2QR0\Desktop\original';  % 경로
input_folder = base_path;
noise_levels = [15, 25, 50];
filter_types = {'gaussian', 'median'};

% === 폴더 경로 설정 ===
output_folders = struct();
output_types = {'noisy', 'gaussian', 'median'};
for t = 1:length(output_types)
    for n = 1:length(noise_levels)
        folder_path = fullfile(base_path, output_types{t}, sprintf('sigma%d', noise_levels(n)));
        output_folders.(output_types{t}){n} = folder_path;
        if ~exist(folder_path, 'dir')
            mkdir(folder_path);
        end
    end
end

% === 이미지 리스트 불러오기 ===
image_files = dir(fullfile(input_folder, '*.png'));
num_images = length(image_files);

% === 결과 저장 구조 초기화 ===
PSNR_values = zeros(length(filter_types), length(noise_levels));
SSIM_values = zeros(length(filter_types), length(noise_levels));

% === 메인 루프 ===
for n = 1:length(noise_levels)
    sigma = noise_levels(n);
    var = (sigma/255)^2;

    for i = 1:num_images
        img_name = image_files(i).name;
        I = im2double(imread(fullfile(input_folder, img_name)));
        if size(I,3) == 3
            I = rgb2gray(I);
        end

        % Gaussian noise 추가
        noisy = imnoise(I, 'gaussian', 0, var);
        noisy_name = sprintf('%s_sigma%d.png', img_name(1:end-4), sigma);
        imwrite(noisy, fullfile(output_folders.noisy{n}, noisy_name));

        % Gaussian filter
        h = fspecial('gaussian', [3 3], 1);
        denoised_g = imfilter(noisy, h, 'replicate');
        imwrite(denoised_g, fullfile(output_folders.gaussian{n}, noisy_name));
        PSNR_values(1,n) = PSNR_values(1,n) + psnr(denoised_g, I);
        SSIM_values(1,n) = SSIM_values(1,n) + ssim(denoised_g, I);

        % Median filter
        denoised_m = medfilt2(noisy, [3 3]);
        imwrite(denoised_m, fullfile(output_folders.median{n}, noisy_name));
        PSNR_values(2,n) = PSNR_values(2,n) + psnr(denoised_m, I);
        SSIM_values(2,n) = SSIM_values(2,n) + ssim(denoised_m, I);
    end
end

% === 평균 계산 ===
PSNR_values = PSNR_values / num_images;
SSIM_values = SSIM_values / num_images;

% === 수치 출력 ===
fprintf('✅ 평균 PSNR / SSIM (over %d images)\n', num_images);
for n = 1:length(noise_levels)
    sigma = noise_levels(n);
    fprintf('\nNoise σ = %d\n', sigma);
    for f = 1:length(filter_types)
        fprintf('  [%s]  PSNR: %.4f dB | SSIM: %.4f\n', ...
            upper(filter_types{f}), PSNR_values(f,n), SSIM_values(f,n));
    end
end

% === 그래프 시각화 ===
figure;
subplot(1,2,1);
bar(PSNR_values');
title('PSNR by Filter and Noise Level');
xlabel('Noise σ');
ylabel('Average PSNR (dB)');
xticklabels({'15','25','50'});
legend({'Gaussian', 'Median'}, 'Location', 'northeast');
grid on;

subplot(1,2,2);
bar(SSIM_values');
title('SSIM by Filter and Noise Level');
xlabel('Noise σ');
ylabel('Average SSIM');
xticklabels({'15','25','50'});
legend({'Gaussian', 'Median'}, 'Location', 'northeast');
grid on;
