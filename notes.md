
# 1. Bootstrap

Bootstrap methods are a class of methods that estimate the distribution of a population by resampling.

they are often used when the distribution of the population is unkown and the sample is the only given information. 

### $E(X^{*}) \text{ \& } V(X^{*})$ in bootstrap
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



