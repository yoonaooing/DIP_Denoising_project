# DIP_Denoising_project
🧠 Digital Image Processing Project: Image Denoising with DnCNN (DnCNN을 활용한 이미지 노이즈 제거)

Self-driving cars rely heavily on image data, which can be degraded by noise, especially under low-light conditions. 
This project aims to improve image quality using both classical methods and deep learning (DnCNN).


📁 Dataset & Tools

Dataset:
https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/bsds/

Train: BSD400

Validation: Set12

Test: BSD68

Environment: Google Colab, PyTorch

🔧 Methods

1. Classical Denoising
Gaussian Filter: good for random noise removal, but causes edge blur.

Median Filter: better edge preservation, effective on salt-and-pepper noise.

2. DnCNN (Pretrained)
Deep CNN model using residual learning.

Outperforms classical filters, especially in high-noise scenarios.

3. DnCNN (Revised)
   
Modified structure:

Depth: 17 → 18 layers

Channels: 64 → 128

Improved PSNR & SSIM, especially at σ = 50.

Added early stopping, memory optimization, and patch generation refinement.

📊 Results (PSNR / SSIM)

Noise σ )	Gaussian / Median	/ DnCNN (Pre)	/ DnCNN (Rev)

σ = 15 )	29.86 / 0.81	28.69 / 0.75	31.71 / 0.89	32.96 / 0.89

σ = 25 )	27.31 / 0.68	26.02 / 0.60	29.20 / 0.83	30.38 / 0.83

σ = 50 )	22.73 / 0.45	21.38 / 0.37	26.21 / 0.71	32.93 / 0.88

✅ Conclusion

DnCNN (Pretrained) outperformed classical denoising filters (Gaussian, Median) across all noise levels:

At σ = 15, DnCNN improved PSNR by +1.85 dB (vs. Gaussian) and SSIM by +0.08

At σ = 25, DnCNN improved PSNR by +1.89 dB (vs. Gaussian) and SSIM by +0.14

At σ = 50, DnCNN improved PSNR by +3.48 dB (vs. Gaussian) and SSIM by +0.26
______________________________________________________________________________________________________________

DnCNN (Revised) architecture further enhanced denoising performance:

At σ = 50, Revised DnCNN achieved PSNR of 32.93 dB, +6.72 dB higher than Gaussian and +1.72 dB higher than Pretrained DnCNN

At σ = 25, performance gain was +3.06 dB over Gaussian and +1.18 dB over Pretrained

SSIM values also approached 0.89, indicating high structural similarity to ground truth images even under heavy noise
______________________________________________________________________________________________________________

The revised architecture proved especially effective in high-noise scenarios, validating that:

Increasing depth (17 → 18 layers) and width (64 → 128 channels) enables better feature extraction

Model optimization (e.g., early stopping, patching strategy) enhances stability and generalization


