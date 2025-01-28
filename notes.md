
# 1. Bootstrap

Bootstrap methods are a class of methods that estimate the distribution of a population by resampling.

they are often used when the distribution of the population is unkown and the sample is the only given information. 

__Bootstraping constists of 4 step:__
1. Make a bootstraped dataset
2. calculate something (for example the mean/mean/standard deviation)
3. keep track of that calculation
4. repeat steps 1-3...

### $E(X^{* }) \text{ \& } V(X^{*})$ in bootstrap
In the "boostrap world" we have to estimate the expected value and the variance as the following:

$$E(X^{*}) = \sum_{i}^{n} x_{i} p(x_{i}) = \sum_{i}^{n} x_{i} \cdot \frac{1}{n} = x_{mean} $$

$$V(X^{*})= E[X^{*}- E[X^{*}]]^2 = E[X^{*}- X_{mean}]^2 = \sum_{i} (x_{i} - x_{mean})^2 \cdot p(x_{i})$$
$$= \sum_{i} (x_{i} - x_{mean})^2 \cdot \frac{1}{n}$$

### 1.1 general idea:
Use the sample to estimate the unkown sampling distribution of the data

(1) Generate B-number of samples, sampled uniformly with replacement from
$\{x_{1}, ..., x_{n} \}$.
$$ x^{*b} = x_{1}^{*}, ..., x_{n}^{*}$$
and compute the distribution every time
$$ \theta^{(b)} = \theta(x_{1}^{*}, ..., x_{n}^{*})$$

Use this to calculate the empirical CDF of 
$\theta^{(1)}, ..., \theta^{(B)}$ that will give you the boostrap estimate of $F_{\theta}$.

## 1.2 Bias of estimation
The bias of the estimator calculates how for the exopected value is from the true value of the parameter $\theta$.

__Compute bias:__

$\text{bias} (\theta) = E(\theta^{*}) - \theta$

where $\theta^{*}$ is the exptected value (or mean):
$$E(\theta^{*})= \theta_{mean} = \frac{1}{B} \sum_{b=1}^{B} \theta^{*b}$$

## 1.3 Bias corrected Estimate

$$\theta_{bc}= \theta^{*} - bias(\theta) = \theta^{*} - E(\theta^{*}) + \theta_{true}$$
$$E(\theta_{bc}) = E(\theta^{*}) - E(\theta^{*}) + \theta_{true} = \theta_{true}$$


## 1.4 Variance 
__Compute Variance:__
$$\text{var}(\theta) = \frac{1}{B-1} \sum_{b=1}^{B} \left( \theta^{(b)} - \theta^{*} \right)^2$$


## 1.5 standard normal boostrap - CI
This simple and easy to compute but it ignores varibility in standard errors.

- Let $\theta$ be an unknown paramter estimated by: $\theta^{*}(X_{1},X_{2},...X_{n})$
how do we construct a (1-$\alpha$)CL for $\theta$ ?

### Answer:
(1) assume $\theta$ is unbiased and normal and that $$Z= \frac{\theta^{*} - \theta}{se(\theta^{*})} \approx N(0,1)$$

(2) Use boostrap to estimate $$se^{*}(\theta^{*})$$

(3) (1-$\alpha$) CI: $$\theta^{*} \pm z_{\alpha/2} \cdot se(\theta^{*})$$


## 1.6 Bootstrap t-interval

do the following B-times:

1. 
(1.1) generate bootstrap sample $x^{*,b}=x^{*}_{1},...,x_{n}^{*}$ by sampling with replacement from $x_{1},...x_{n}$.

(1.2) Compute $\theta^{*(b)} = \theta^{*}(x^{*}_{1},...,x^{*}_{n})$

(1.3) Compute or estimate the standard error for each b:
$$se^{*}(\theta^{*(b)})$$
a boostrap estimate will in this case sample from $x^{*(b)} \text{ and not } x$.

(1.4) Compute: $$t^{(b)}= \frac{\theta^{*(b)} - \theta}{se^{*}(\theta^{*(b)})}$$

2.

(2.2)
find the sample quantiles
$$t^{*}_{\alpha/2} \text{ and } t^{*}_{1-\alpha/2}$$
from the sample of the replicates: $t_{1}, ...,t_{B}$

(2.3)
compute the standard error:
$$se^{*}(\theta^{*})=\sqrt{\frac{1}{B-1} \cdot \sum_{b=1}^{B} \left( \theta^{*(b)} - \theta \right)^{2} } $$\\


(2.4)
$(1-\alpha)$CI: $$(\theta^{*} - t^{ *}_{1- \alpha /2} \cdot se^{ *}(\theta^{ *}), \theta^{*} - t^{ *}_{\alpha /2} \cdot se^{ *}(\theta^{ *}))$$