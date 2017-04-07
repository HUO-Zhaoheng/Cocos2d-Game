function [q]=guided_filter(Img,p,r,sigma)
[m,n]=size(Img);
q=zeros(m,n);
adjacent_size=(2*r+1)*(2*r+1);
a_k=zeros(m,n);
b_k=zeros(m,n);
for i = r+1 : m-r
    for j = r+1 : n-r
         if(i==334&&j==5)
            miu_k=0.0;
        end
        miu_k=0.0;
        p_k=0.0;
        variance=0.0;
        for k=-r:r
            for o=-r:r
                if(i+k<=0||j+o<=0||i+k>=m||j+o>=n)
                    continue;
                end
                a_k(i,j)=Img(i+k,j+o)*p(i+k,j+o)+a_k(i,j);
                miu_k=Img(i+k,j+o)+miu_k;
                p_k=p(i+k,j+o)+p_k;
            end
        end
        p_k=p_k/adjacent_size;
        miu_k=miu_k/adjacent_size;
        for k=-r:r
            for o=-r:r
                if(i+k<=0||j+o<=0||i+k>=m||j+o>=n)
                    continue;
                end
                variance=variance+(Img(i+k,j+o)-miu_k)^2;
            end
        end
        variance=variance/adjacent_size;

        a_k(i,j)=(1/adjacent_size*a_k(i,j)-miu_k*p_k)/(variance+sigma);
        b_k(i,j)=p_k-a_k(i,j)*miu_k;
    end
end
a_k_filtered=zeros(m,n);
b_k_filtered=zeros(m,n);
for i = r+1 : m-r
    for j = r+1 : n-r
        for k=-r:r
            for o=-r:r
                if(i+k<=0||j+o<=0||i+k>=m||j+o>=n)
                    continue;
                end
                a_k_filtered(i,j)=a_k(i+k,j+o)+a_k_filtered(i,j);
                b_k_filtered(i,j)=b_k(i+k,j+o)+b_k_filtered(i,j);
            end
        end
    end
end
a_k_filtered=a_k_filtered/adjacent_size;
b_k_filtered=b_k_filtered/adjacent_size;
q(i,j)=a_k_filtered*Img+b_k_filtered;