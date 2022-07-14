package app.voicesearch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private SecurityUserDetailsService userDetailsService;
	
	@Override
	public void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());
	}

	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
		authenticationProvider.setUserDetailsService(userDetailsService);
		return authenticationProvider;
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/console/**").permitAll().antMatchers("/h2/**").permitAll().antMatchers("/error").permitAll()
				.antMatchers("/app/**").access("hasRole('ROLE_USER')").and().formLogin().loginPage("/login")
				.failureUrl("/login?error").usernameParameter("username").passwordParameter("password")
				.defaultSuccessUrl("/app").and().logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/login?logout")).logoutSuccessUrl("/logout.done")
				.deleteCookies("JSESSIONID").invalidateHttpSession(true).and().exceptionHandling()
				.accessDeniedPage("/accessDenied").and().csrf().disable();
		http.headers().frameOptions().sameOrigin();
	}

}