# DIP_Denoising_project
🧠 Digital Image Processing Project: Image Denoising with DnCNN (DnCNN을 활용한 이미지 노이즈 제거)

Self-driving cars rely heavily on image data, which can be degraded by noise, especially under low-light conditions. 
This project aims to improve image quality using both classical methods and deep learning (DnCNN).


📁 Dataset & Tools

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

DnCNN significantly outperforms classical methods in image denoising.

Revised model proves particularly effective under high-noise conditions (σ=50).

Demonstrates the importance of architecture tuning in deep learning.


