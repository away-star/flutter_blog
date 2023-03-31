import 'dart:math';
import 'package:my_blog/pages/home/essay.dart';


List<String> contents = [
  """
---
theme: condensed-night-purple
---
### 在springcloud alibaba中集成gateway
##### 新建maven项目service-gateway并在pom文件中导入springcloud gateway依赖
```pom
      <!--gateway⽹关-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>
```
##### 加入nacos服务发现依赖和nacos服务注册中心适配
```
  <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>

```
#### 在bootstrap.yml配置文件中进行相关配置
```
server:
  port: 9000
spring:
  application:
    name: service-gateway
  cloud:
    gateway:
      discovery:
        locator:
          #让gateway可以发现nacos中的微服务
          enabled: true
    nacos:
      discovery:
        server-addr: localhost:8848
```
`至此便完成了gateway路由的自动装配，通过访问9000端口完成请求的分发了`

#### 启动nacos


![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0db7976ddf4142b4a05ecd48a7b6425a~tplv-k3u1fbpfcp-watermark.image?)

#### 书写测试接口controller
```
package com.example.servicecontent.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author star
 * @date 2023/1/28 12:05
 */
@Slf4j
@RestController
@CrossOrigin
@RequestMapping("/content")
@RefreshScope
public class testController {

    @GetMapping("/777")
    public String post(){
        return "77777777777777777777777777777777777";
    }
}

```


#### 启动果然报错

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2a0ab55d191e4893b9bcaafa315a1df9~tplv-k3u1fbpfcp-watermark.image?)

`好在全网搜寻找到了解决方案`
原来是我继承了common工程，导致加入springweb依赖导致的报错，删除依赖，重新启动

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fdea8977ef2c48f98d4763dc4d23cf1c~tplv-k3u1fbpfcp-watermark.image?)

#### 输入9000端口测试

`再次报错`

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ebae6d3d76134b379ceb363b3990a745~tplv-k3u1fbpfcp-watermark.image?)
这下我发现了nacos的问题，springcloud gateway竟然在public分支里面，我的其他服务都在blog分支

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6c8a1592d97d436d8672a923953cc1eb~tplv-k3u1fbpfcp-watermark.image?)
`修改bootstrap.yml文件后再次启动 -------successful`

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/93c610f606114b4dab71a3c650e0db31~tplv-k3u1fbpfcp-watermark.image?)

### springcloud gateway自定义配置详解

`如果想要自定义路由加载的话会用到以下参数`

- id，路由标识符，区别于其他 Route。
- uri，路由指向的⽬的地 uri，即客户端请求最终被转发到的微服务。
- order，⽤于多个 Route 之间的排序，数值越⼩排序越靠前，匹配优先级越⾼。
- predicate，断⾔的作⽤是进⾏条件判断，只有断⾔都返回真，才会真正的执⾏路由。
- filter，过滤器⽤于修改请求和响应信息。


### 全网爆火的gateway执行流程图

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9fe328565ae6486380181f8fb3d8c62c~tplv-k3u1fbpfcp-watermark.image?)

#### 其实还有一小部分gateway中的拦截器设置，俺觉得没啥必要不如去微服务中配酒不过多阐述啦


  """,


  """
---
theme: nico
---
### spring-cloud-starter-oauth2+securit简介

##### 认证

- 用户认证就是判断一个用户的身份是否合法的过程，用户去访问系统资源时系统要求验证用户的身份信 息，身份合法方可继续访问，不合法则拒绝访问。常见的用户身份认证方式有：用户名密码登录，二维 码登录，手机短信登录，指纹认证等方式。

`认证是为了保护系统的隐私数据与资源，用户的身份合法方可访问该系统的资源。`
#### 授权
- 授权是用户认证通过后，根据用户的权限来控制用户访问资源的过程，拥有资源的访问权限则正常访 问，没有权限则拒绝访问。

`认证是为了保证用户身份的合法性，授权则是为了更细粒度的对隐私数据进行划分，授权是在认证通过 后发生的， 控制不同的用户能够访问不同的资源。`

#### RBAC模型
`主体 -》 角色 -》 资源 -》行为`

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f2606eb94497441fb84648424a748d5e~tplv-k3u1fbpfcp-watermark.image?)
### spring-cloud-starter-oauth2+security使用

#### 相关依赖引入
- spring-cloud-starter-oauth2+security是一套完整的用户登录授权系统，在认证服务上主要有三个依赖：`spring-cloud-starter-security、spring-cloud-starter-oauth2、spring-security-jwt`
```

        <!--spring security相关依赖-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-oauth2</artifactId>
        </dependency>

  <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-jwt</artifactId>
            <version>1.1.1.RELEASE</version>
        </dependency>

```
- 在其他需要权限访问的服务上主要包含两个依赖：

```
  <!--spring security相关依赖-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-oauth2</artifactId>
        </dependency>

```

#### 认证服务搭建
- 这里主要做security和oauth2的相关配置
- 主要由以下四个配置文件


![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/64fdb305f8934f128f141085735d9945~tplv-k3u1fbpfcp-watermark.image?)

- WebSecurityConfig主要做springsecurity相关的配置
```
@EnableWebSecurity //开启security服务
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true) //允许在方法上加的注解来配置权限
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    DaoAuthenticationProviderCustom daoAuthenticationProviderCustom;

    //使用自己定义DaoAuthenticationProviderCustom来代替框架的DaoAuthenticationProvider
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(daoAuthenticationProviderCustom);
    }

    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        //密码为明文方式
        return NoOpPasswordEncoder.getInstance();
        //return new BCryptPasswordEncoder();
    }

    //配置安全拦截机制
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/pow/**").authenticated()//访问/r开始的请求需要认证通过
                .anyRequest().permitAll()//其它请求全部放行
                .and()
                .formLogin().successForwardUrl("/login-success");//登录成功跳转到/login-success
        http.logout().logoutUrl("/logout");//退出地址
    }

}

```
- TokenConfig在认证服务中主要作token的生成配置

```
@Configuration
public class TokenConfig {

    private String SIGNING_KEY = "030321liuxinyu";//和其他服务一致来解析token

    @Autowired
    TokenStore tokenStore;

//    @Bean
//    public TokenStore tokenStore() {
//        //使用内存存储令牌（普通令牌）
//        return new InMemoryTokenStore();
//    }

    @Autowired
    private JwtAccessTokenConverter accessTokenConverter;

    @Bean
    public TokenStore tokenStore() {
        return new JwtTokenStore(accessTokenConverter());
    }

    @Bean
    public JwtAccessTokenConverter accessTokenConverter() {
        JwtAccessTokenConverter converter = new JwtAccessTokenConverter();
        converter.setSigningKey(SIGNING_KEY);
        return converter;
    }

    //令牌管理服务
    @Bean(name="authorizationServerTokenServicesCustom")
    public AuthorizationServerTokenServices tokenService() {
        DefaultTokenServices service=new DefaultTokenServices();
        service.setSupportRefreshToken(true);//支持刷新令牌
        service.setTokenStore(tokenStore);//令牌存储策略

        TokenEnhancerChain tokenEnhancerChain = new TokenEnhancerChain();
        tokenEnhancerChain.setTokenEnhancers(Arrays.asList(accessTokenConverter));
        service.setTokenEnhancer(tokenEnhancerChain);

        service.setAccessTokenValiditySeconds(7200); // 令牌默认有效期2小时
        service.setRefreshTokenValiditySeconds(259200); // 刷新令牌默认有效期3天
        return service;
    }}
```

- AuthorizationServer主要是授权方面也就是spring-cloud-starter-oauth2相关的配置

```
@Configuration
@EnableAuthorizationServer
@Slf4j
public class AuthorizationServer extends AuthorizationServerConfigurerAdapter {


    @Resource(name = "authorizationServerTokenServicesCustom")
    private AuthorizationServerTokenServices authorizationServerTokenServices;

    @Autowired
    private AuthenticationManager authenticationManager;

    //客户端详情服务
    @Override
    public void configure(ClientDetailsServiceConfigurer clients)
            throws Exception {

        clients.inMemory()// 使用in-memory存储
                .withClient("starBlog")// client_id
                .secret("030321liuxinyu")//客户端密钥
//                .secret(new BCryptPasswordEncoder().encode("XcWebApp"))//客户端密钥
                .resourceIds("starBlog")//资源列表

                .authorizedGrantTypes("authorization_code", "client_credentials", "implicit", "refresh_token", "password")// 该client允许的授权类型authorization_code,password,refresh_token,implicit,client_credentials
                .scopes("all")// 允许的授权范围
                .autoApprove(false)//false跳转到授权页面
                //客户端接收授权码的重定向地址
                .redirectUris("http://www.xuecheng-plus.com")
        ;
    }


    //令牌端点的访问配置
    @Override
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) {
        endpoints
                .authenticationManager(authenticationManager)//认证管理器
                .tokenServices(authorizationServerTokenServices)//令牌管理服务
                .allowedTokenEndpointRequestMethods(HttpMethod.POST);
    }

    //令牌端点的安全配置
    @Override
    public void configure(AuthorizationServerSecurityConfigurer security) {
        security
                .tokenKeyAccess("permitAll()")                    //oauth/token_key是公开
                .checkTokenAccess("permitAll()")                  //oauth/check_token公开
                .allowFormAuthenticationForClients()                //表单认证（申请令牌）
        ;
    }

}
```
- DaoAuthenticationProviderCustom是一个很重要的配置，通过这个修改的springsecuritu原先提供的登录方案（账号密码登录），但当前环境肯定涉及到多种登录方式，我们通过重写`additionalAuthenticationChecks和setUserDetailsService`方法来自定义登录方式

```
@Slf4j
@Component
public class DaoAuthenticationProviderCustom extends DaoAuthenticationProvider {

 @Autowired
 public void setUserDetailsService(UserDetailsService userDetailsService) {
  super.setUserDetailsService(userDetailsService);
 }


 //不再校验密码
 protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {

 }


}

```

- 至此认证服务的相关配置就完成啦，我们可以通过`POST localhost:8081/oauth/token?client_id=starBlog&client_secret=030321liuxinyu&grant_type=password&username={"account":"账号","authType":"登录方式","password":"密码"}`来进行测试


![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cf8661a32e914bee9e24ed8e7105e399~tplv-k3u1fbpfcp-watermark.image?)

这就是前端用户点击登录后获得的信息，然后将该token存储在本地，用户每次访问的时候都携带token即可，

- oauth也提供了校验token的方法`POST localhost:8081/oauth/check_token?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsieHVlY2hlbmctcGx1cyJdLCJ1c2VyX25hbWUiOiJ7XCJpZFwiOjE2MTY1MTYxNjUsXCJwaG9uZVwiOlwiMTM2NDg4MzcwOTNcIixcIkVtYWlsXCI6XCIyMDY0OTg5NDAzQHFxLmNvbVwiLFwiYWNjb3VudFwiOlwiMjA2NDk4OTQwM1wifSIsInNjb3BlIjpbImFsbCJdLCJleHAiOjE2NzUyNTI3MjIsImF1dGhvcml0aWVzIjpbInRlc3QiXSwianRpIjoiMDU1MjBlOTYtMTVhOS00MjAzLWExMWItNjRjZTNhNDQ5ZTM4IiwiY2xpZW50X2lkIjoic3RhckJsb2cifQ.I6wM4jZJdSA07gTnzmlP59vzqvm1hxNcNt3ejE0mR8w`

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2343a98e4ad64ee3a756ae144869cc7a~tplv-k3u1fbpfcp-watermark.image?)

#### 资源服务搭建
- 引入配置文件，相比于认证服务，资源服务的配置量少很多，主要有以下两个配置文件

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/27ad3d5c189a4243beae77449c746b46~tplv-k3u1fbpfcp-watermark.image?)
- TokenConfig(和认证服务的类似，但不需要token生成)

```
@Configuration
public class TokenConfig {

    String SIGNING_KEY = "key";


    @Autowired
    private JwtAccessTokenConverter accessTokenConverter;

    @Bean
    public TokenStore tokenStore() {
        return new JwtTokenStore(accessTokenConverter());
    }

    @Bean
    public JwtAccessTokenConverter accessTokenConverter() {
        JwtAccessTokenConverter converter = new JwtAccessTokenConverter();
        converter.setSigningKey(SIGNING_KEY);
        return converter;
    }
}

```

- ResouceServerConfig（资源权限的相关配置）
```
@Configuration
@EnableResourceServer
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class ResouceServerConfig extends ResourceServerConfigurerAdapter {


    //资源服务标识
    public static final String RESOURCE_ID = "starBlog";

    @Autowired
    TokenStore tokenStore;

    @Override
    public void configure(ResourceServerSecurityConfigurer resources) {
        resources.resourceId(RESOURCE_ID)//资源 id
                .tokenStore(tokenStore)
                .stateless(true);
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http.csrf()
                .disable()
                .authorizeRequests()
                .antMatchers( "/**").authenticated()//所有/r/**的请求必须认证通过
                .anyRequest().permitAll()
        ;
    }

}
```

- 这样资源服务就搭建好了，我们访问资源

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e8d6f8c7a3704bfaa38e9523ae869698~tplv-k3u1fbpfcp-watermark.image?)

- 在资源服务的方法上添加`@PreAuthorize("hasAuthority('test')")`可以指定拥有某项权限的用户才可以访问



> 这样一个简单的spring-cloud-starter-oauth2+securit+jwt微服务就搭建完成了 
  """,

  """
---
theme: orange
---

# nexj.js特点

#### 服务端渲染/客户端渲染/同构渲染的优缺点

- 首屏等待

在 SPA 模式下，所有的数据请求和 Dom 渲染都在浏览器端完成，所以当我们第一次访问页面的时候很可能会存在“白屏”等待，而服务端渲染所有数据请求和 html内容已在服务端处理完成，浏览器收到的是完整的 html 内容，可以更快的看到渲染内容，在服务端完成数据请求肯定是要比在浏览器端效率要高的多。

- SEO 优化

有些网站的流量来源主要还是靠搜索引擎，所以网站的 SEO 还是很重要的，而 SPA 模式对搜索引擎不够友好，要想彻底解决这个问题只能采用服务端直出。

##### 服务端渲染优点
- 前端渲染时间。因为后端拼接htm，浏览器只需直接渲染出来。
- 有利于SEO。服务端有完整的html页面，所以爬虫更容易获得信息，更利于seo
- 无需占用客户端资源，模板解析由后端完成，客户端只需解析标准的html页面，这样对客户端的资源占用更少，尤其是移动端，可以更加省电。
- 后端生成静态化文件。即生成缓存片段，这样就可以减少数据库查询浪费的时间了，且对于数据变化不大的页面非常高效 等。

##### 服务端渲染缺点
- 不利于前后端分离，开发效率很低
- 占用服务器端资源。请求过多对服务器压力很大。
- 即使局部页面发生变化也需要重新请求整个页面，费流量等。


#### next.js 项目搭建
- 先上图，next.js渲染流程

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7304e8d0a152439ab09b0f36333b5696~tplv-k3u1fbpfcp-watermark.image?)

- 使用next.js官方脚手架快速生成next.js项目

> npm init next-app nextjs-blog --example "https://github.com/vercel/next-learn-starter/tree/master/learn-starter"

此时使用`yarn dev`就可以迅速启动项目啦


![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1b86b8bb88c7479ebeddb9bbb6ecf393~tplv-k3u1fbpfcp-watermark.image?)

- next.js初探----页面跳转link

```
import Link from 'next/link'

<Link href="/test">
   <span>test`1</span>
   <span>test`2</span>
 </Link>
```
- next.js初探----页面跳转router
```
import Router from 'next/router'
<button onClick={()=>{Router.push('/test')}}>去test页面</button>
```

- next.js初探----接收页面跳转传入参数
```

import { withRouter } from 'next/router'
import Link from 'next/link'

const  Test = ({router}) =>{
    return(
        <div>
            <p>{router.query.id}</p>
            <Link href={{pathname:'/'}}>
                <span>回首页</span>
            </Link>
        </div>
    )
}
export default withRouter(Test)

```

- next.js初探----路由钩子

```
// 监听
Router.events.on('routeChangeStart', handleRouteChange)
// 关闭
Router.events.off('routeChangeStart', handleRouteChange)

 Router.events.on('routeChangeStart',(...args)=>{
   console.log('路由开始变化',...args)
})

Router.events.on('routeChangeComplete',(...args)=>{
  console.log('路由结束变化',...args)
})

Router.events.on('beforeHistoryChange,(...args)=>{
  console.log('浏览器 history改变之前',...args)
})

Router.events.on('routeChangeError,(...args)=>{
  console.log('跳转发生错误',...args)
})

Router.events.on('hashChangeStart,(...args)=>{
  console.log('hash模式路由改变刚开始',...args)
})

Router.events.on('hashChangeComplete,(...args)=>{
  console.log('hash模式路由改变结束',...args)
})
```

#### next.js核心---getServerSideProps（老师推荐）

在初始渲染时就拿到数据，需要在页面组件处导出名为getServerSideProps的async函数，如果不需要接口数据做seo，也可以在页面加载后使用ajax请求
```
import { useRouter } from 'next/router'

export async function getServerSideProps(context) {
        // context为路由信息
        const query = context.query
        const id = query.id
        const res = await apirequestxxx(id)

  return {
          // 信息可以在组件的props中拿到
    props: {
                        detailData: res.data
                }
  }
}

const NoData = ({detailData}) => {
  return (
    <div>
      // ...
    </div>
  )
}

```

> 聊胜于无，感觉前后端分离开发才是大势所趋
  """,

  """
---
theme: vue-pro
highlight: solarized-light
---

> `At-rules`规则是目前CSS中一种常见的语法规则，它使用一个`"@"`符号加一个关键词定义，后面跟上语法区块，如果没有则以分号结束即可。  
这种规则一般用于标识文档、引入外部样式、条件判断等等，本文是对该规则的使用总结。`

### @keyframes
> 使用 `@keyframes` 可以创建动画。在动画过程中，您可以更改CSS样式的设定多次。指定的变化时发生时使用％，或关键字“from”和“to”，等价于0％到100％  0％是开头动画，100％是当动画完成。

##### 示例
```
 @keyframes mycolor {
    0% { background-color: red; }
    30% { background-color: darkblue; }
    50% { background-color: yellow; }
    70% { background-color: darkblue; }
    100% { background-color: red; }
  }
```

##### css样式名称
- `animation-name`:动画的名称 用于指定一个@keyframes动画，指定要使用哪一个关键帧
- `animation-name`:动画持续时间 用于定义动画完成一个周期要多少秒或者多少毫秒
- animation-timing-function:动画的运动方式 指定动画将如何完成一个周期,有如下参数，通常不指定  默认ease
```
  ease;默认
  ease-in;  
  ease-out;
  ease-in-out;
  linear;
  steps(数值, 定位) 定位：start/end 默认end指逐步运动
```
- animation-delay:动画在组件渲染后多久开始
- animation-iteration-count:动画循环播放的次数，默认值为1，一般会设定为infinite（一直循环）
- animation-fill-mode：动画在播放完成后的状态，有两个值可以选择
```
  forwards 保持动画结束后的状态(通常选择这个，防止抖动)
  backwards 动画结束后回到最初的状态
```
- animation-direction:动画执行顺序----动画是否应该播放完后逆向交替循环（对设置了多次播放的动画有效），有三个值可供选择：

```
 normal 默认值（即执行完后回到起点再次执行）
 reverse 反向（即直接从终点反向执行到起点再反复）
 alternate 先从起点到终点，再从终点到起点
```

**以上所有css样式可以简写为:**
`animation: 动画执行时间 延迟时间 执行关键帧名称 运动方式 运动次数 结束状态 动画执行顺序`;
**更简形式为:**
``animation: 动画执行时间 执行关键帧名称;``

##### 简单应用
```
div { 
        width: 200px;
        height: 200px;
        background: red;
}
@keyframes mycolor {
        0% { background-color: red; }
        30% { background-color: yellow; }
        60% { background-color: green; }
        100% { background-color: red; }
}
div:hover {
        animation-name: mycolor;
        animation-duration: 5s;
        animation-timing-function: linear;
        animation-iteration-count: 2;
}
```
##### 注意事项
`@keyframes的原理是把元素样式从一个状态慢慢的变为另外一个状态，所以是要能够进行渐变的样式才可以使用`
以下是不能生效的
```
div {
    animation: appear 2s;
}
@keyframes appear {
    from { display:none; }
    to   { display:block;}
}
```
`常用于@keyframes的属性介绍`
- visibility和opacity
- color和background-color
- 盒子模型中的margin、pading、bottom、top、border

想到了再补充其他的

### @media
> 使用 @media，可以针对不同的媒体类型定义不同的样式。
> 使用 @media， 可以针对不同的屏幕尺寸设置不同的样式
> 当你重置浏览器大小的过程中，页面也会根据浏览器的宽度和高度重新渲染页面。

##### 简单示例子
```
@media mediatype and|not|only (media feature) {
    CSS-Code;
}
```
##### 媒体类型
-   all 【默认值】 匹配所有设备，无论是打印设备还是其他普通的现实设备。
-   screen 除打印设备和屏幕阅读设备以外的所有设备
-   speech 能够“读出”页面的屏幕阅读设备，通常供残疾人士使用
-   print 在打印和打印预览的时候生效

`此处一般情况下不写，采用默认值all，当前我们设计的前端项目一般不涉及speech、print、screen的区分`

##### 媒体特征（常用）
- 判断设备是横屏还是竖屏
```
/* 横屏 */ 
@media (orientation: landscape) {} 
/* 竖屏 */ 
@media (orientation: portrait) {}

```
- 匹配设备的最大高度、最大宽度
```
/* 如果高度小于600px */ 
@media (max-height: 600px) {}
/* 如果高度小于480px */ 
@media (max-height: 480px) {}

/*多重判断可以用or或者and*/
@media(min-height: 100px) and (max-height: 200px){
  body { background: #333; color: white; }
}

```
- 判断深色模式
```

/* 深色模式 表示系统更倾向于深色模式*/
@media (prefers-color-scheme: dark) {
    body { background: #333; color: white; }
}
/* 浅色模式 表示系统更倾向于浅色模式*/
@media (prefers-color-scheme: light) {
    body { background: white; color: #333; }
}

```

##### 匹配规则

`从前往后，一旦匹配则终止`

### @import
> 用于导入其他样式文件

- 可以混用条件判断媒体查询
```
/* 宽度小于1000px才会生效 */
@import "./reset.css" screen and (max-width: 1000px); 

```

### @font-face
> @font-face 用于加载自定义字体。属于目前前端比较常用的语法，也有多开源的字体图标库可以使用既支持提供字体资源文件路径进行加载，也支持用户本地安装的字体加载

阿里开源字体库引用 示例
- 引入ttf文件


![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8ee75ec43ce049f9b67eb90a76cd5997~tplv-k3u1fbpfcp-watermark.image?)
- font.css


![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/74729ed2c9c6434ea2f1f3be157d383f~tplv-k3u1fbpfcp-watermark.image?)

- global.less中引入


![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9a2991987be74e94bc56da6126203b2e~tplv-k3u1fbpfcp-watermark.image?)

  """,

  """


## 伪类
- 伪类存在的意义是为了通过选择器找到那些 ①不存在于DOM树中的信息 以及 ②不能被常规CSS选择器获取到的信息
- 伪类由一个冒号 : 开头，冒号后面是伪类的名称和包含在圆括号的可选参数。
- 任何常规选择器都可以在任何位置使用伪类。
- 一些伪类的作用会互斥，另外一些伪类可以同时被同一个元素使用。并且为了满足用户在操作DOM时产生的DOM结构改变，伪类也可以是动态的。

#### 常用伪类
伪类              | 中文释义 | 用法             |
| --------------- | ---- | -------------- |
| **a:link{}**    | 链接   | 在超链接点击之前       |
| **a:visited{}** | 访问过的 | 在超链接点击之后       |
| **a:hover{}**   | 悬停   | 鼠标放到超链接上的时候    |
| **a:active{}**  | 活跃   | 鼠标点击超链接且不松手的时候 |

```
    <p>
        <a href="#" class="active">链接</a>
    </p>
    
.active:link{           /* 点击前 */
    color: orange;
}
.active:visited{        /* 点击后 */
    color: purple;
}
.active:hover{          /* 悬停时 */
    color: red;
}
.active:active{
    color: teal;        /* 点击不松开时 */
}
```
##### `:nth-child()`，`nth-of-type()`·
    `两者用法类似`，均表示第几个该元素
    
## 伪元素
    
##### `::after` 和 `::before`
- ::before和::after是什么?

::before和::after可以添加到选择器以创建伪元素的关键字。伪元素被插入到与选择器匹配的元素内容之前或之后。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9ab8ab45dcc0480f9afc6c12e0f5c787~tplv-k3u1fbpfcp-watermark.image?)
- content属性
1. ::before和::after下特有的content，用于在css渲染中向元素逻辑上的头部或尾部添加内容。
2. ::before和::after必须配合content属性来使用，content用来定义插入的内容，content必须有值，至少是空
3. 这些添加不会出现在DOM中，不会改变文档内容，不可复制，仅仅是在css渲染层加入。所以不要用:before或:after展示有实际意义的内容，尽量使用它们显示修饰性内容

- content取值

1. string（使用引号包一段字符串，将会向元素内容中添加字符串）

```
 p::before{
    content: "《";
    color: #000000;
}
p::after{
    content: "》";
    color:#000000;
}

```
2. attr() ------通过attr()调用当前元素的属性，比如图片alt提示文字或者链接的href地址显示

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b9ab6e91405d4d38bf73f70881e3872e~tplv-k3u1fbpfcp-watermark.image?)

3. url()/uri() ----------用于引用媒体文件。比如：“百度”前面给出一张图片，后面给出href属性。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6c847d9aa82d4333bcda0e79e3e304f0~tplv-k3u1fbpfcp-watermark.image?)\

- content注意事项

1. URL不能使用引号。如果你将URL用引号括起来，那么它会变成一个字符串和插入文本“url(image.jpg)”作为其内容，插入的而不是图像本身。
2. content属性，直接使用图片，即使写width,height也无法改变图片大小;

*解决方案：如果要解决这个问题，可以把content:''写成空，使用background:url()来添加图片*

```
/*伪元素添加图片：*/
.wrap:after{
    /*内容置为空*/
    content:"";
    /*设置背景图，并拉伸*/
    background:url("img/06.png") no-repeat center;
    /*必须设置此伪元素display*/
    display:inline-block;
    /*必须设置此伪元素大小（不会被图片撑开）*/
    background-size:100%;
    width:100px;
    height:100px;
}
```
3. 苹果端伪元素不生效,img、input和其他的单标签是没有:after和:before伪元素的（在部分浏览器中没有，如:苹果端会发现无效），因为单标签本身不能有子元素。
*解决方案：给img包一个div可以解决*


## 参考表

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2b3dfd02d0ea41d79601aed439a4a344~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f047d458fb5943fc8005c21a49286d68~tplv-k3u1fbpfcp-watermark.image?) 
  """
];


List<String> themes = [
  '探索新技术：从头开始学习',
  '为你的代码库添加自动化测试',
  '最佳代码实践：如何编写干净、可维护的代码',
  '管理复杂的代码库：使用 Git 的高级技巧',
  '如何减少应用程序的错误和崩溃',
  '构建高性能的分布式系统',
  '全面了解 Web 开发中的前沿技术',
  '数据结构与算法：提高代码效率的秘诀',
  '了解机器学习的基础知识',
  '从头学习深度学习：理论与实践',
  '如何构建安全的 Web 应用程序',
  '了解云计算的基础知识',
];

List<String> comments = [
  '这个主题很有趣！',
  '感谢分享这么有价值的文章。',
  '我学到了很多新知识。',
  '讲解得非常清晰，易于理解。',
  '非常好的技术分享。',
  '希望有更多的实战案例。',
  '非常感谢你的精彩分享。',
  '这篇文章对我帮助很大。',
  '非常棒的内容！',
  '简单易懂，通俗易懂。',
  '讲得真是太好了，连我这个小白都听懂了。',
  '非常期待你的下一篇文章。',
  '这个主题真的很实用。',
  '非常鼓励你继续分享你的知识。',
  '这篇文章让我受益匪浅。',
  '非常喜欢这篇文章的风格。',
  '写得非常不错，期待更多。',
  '我还需要更多这样的文章。',
  '非常感谢你的详细讲解。',
  '你的文章让我欲罢不能。',
];

String getAuthor() {
  List<String> names = ['Alice', 'Bob', 'Charlie', 'David', 'Emily'];
  Random random = Random();
  int nameIndex = random.nextInt(names.length);
  String name = names[nameIndex];
  return name;
}


String getDate() {
  List<DateTime> dates = [
    DateTime(2022, 1, 1),
    DateTime(2022, 1, 2),
    DateTime(2022, 1, 3),
    DateTime(2022, 1, 4),
    DateTime(2022, 1, 5),
  ];
  Random random = Random();
  int dateIndex = random.nextInt(dates.length);
  DateTime date = dates[dateIndex];
  return date.toString();
}



String geneTitle() {
  Random random = Random();
   return themes[random.nextInt(themes.length)];
}

List<String> geneComments() {
  Random random = Random();
  int count = random.nextInt(15) + 1;
  List<String> list = [];
  for (int i = 0; i < count; i++) {
    list.add(comments[random.nextInt(comments.length)]);
  }
  return list;
}
String geneContent() {
  Random random = Random();
  int count = random.nextInt(10) + 1;
  String content = '';
  for (int i = 0; i < count; i++) {
    content += contents[random.nextInt(contents.length)];
  }
  return content;
}




String geneEssay() {
  List<String> sentenceStarts = [
    '在现代社会中，信息技术功不可没。',
    '当我们看到网络上流传的各种有趣的应用程序时，',
    '软件开发已经成为现代社会中最为重要的行业之一。',
    '云计算技术改变了我们生活的方式，',
    '在过去的几年里，人工智能技术取得了长足的进步，',
    '在移动端技术越来越成熟的今天，',
    '现代软件开发的复杂度越来越高，',
    '人们在游戏中得到的乐趣越来越多，',
    '随着微服务架构的普及，',
    '在现代软件开发中，架构设计已成为关键。',
  ];

  List<String> sentenceMiddles = [
    '今天，我们开发的应用程序在各个领域中扮演着重要角色，',
    '我们会意识到软件开发过程中的挑战和机遇，',
    '每天都会涌现出许多新兴的软件公司，',
    '使得我们可以更加高效、便捷的获取信息和资源，',
    '各领域的专家都在不断探索人工智能在各个领域的应用，',
    '我们需要加强对移动端技术的学习和研究，',
    '我们可以通过使用各种现代工具来简化这一过程，',
    '现代游戏开发人员需要花费更多的精力在游戏性和表现上，',
    '微服务架构可以帮助我们摆脱复杂的传统架构，',
    '构建高质量的架构是开发人员最重要的任务之一。',
  ];

  List<String> sentenceEnds = [
    '这是一个真正充满挑战，但又充满乐趣的时代。',
    '软件开发行业将会迎来更好、更有趣的未来。',
    '在这个竞争激烈的市场中，我们需要保持创新和创造力。',
    '从而为我们的生产生活创造更多的可能性。',
    '我们可以预见未来软件技术将会如何改变我们的生活。',
    '软件开发行业已经成为现代社会中最为引人注目的行业之一。',
    '这是一个颇具挑战性和机遇的时代。',
    '我们需要不断通过学习和创新来应对不断变化的市场需求。',
    '通过使用各种工具和技术，我们可以更加高效地完成软件项目。',
    '我们需要不断寻找创新的架构设计和开发方式，以应对未来的挑战。',
  ];

  Random random = Random();

  return '${sentenceStarts[random.nextInt(sentenceStarts.length)]}'
        '${sentenceMiddles[random.nextInt(sentenceMiddles.length)]}'
        '${sentenceEnds[random.nextInt(sentenceEnds.length)]}';
}


//! 生成随笔
List<Post_essay> generatePost_essay(int count) {
  Random random = Random();
  List<String> imageUrls = [];
  List<Post_essay> posts = [];

  for (int i = 0; i < count; i++) {
    int randomImageCount = random.nextInt(9) + 1;
    List<String> images = List.generate(randomImageCount,
            (index) => 'https://www.itying.com/images/flutter/${random.nextInt(6) + 1}.png');
    Post_essay post = Post_essay(
      author: "作者 ${i + 1}",
      publishTime: "${2 * (i + 1) + random.nextInt(2)}小时前",
      content: geneEssay(),
      images: images,
    );
    posts.add(post);
  }

  return posts;
}