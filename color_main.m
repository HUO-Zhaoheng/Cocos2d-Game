image_name='beauty_with_freckle.bmp';
Img=imread(image_name);
p=imread(image_name);
[m,n,channel_num]=size(Img);
result=zeros(m,n,channel_num);
r=3;
sigma=0.3;
for t=0:0
    sigma=0.1;
    for l=0:0
        for s=1:channel_num
            q=guided_filter(Img(:,:,s),p,r,sigma*sigma);
            result(:,:,s)=q;
            sigma=sigma*2;
        end
        k=4.5;
        g_mask=double(Img)-result;
        g=double(Img)+k*g_mask;
        imwrite(uint8(g),sprintf('%s%d%s%f%s%s','r_is_',r,'_sigma_is_',sigma,'_',image_name),'bmp');
    end
    r=2*r;
end

