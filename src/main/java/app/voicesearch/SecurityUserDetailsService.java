package app.voicesearch;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

@Component
public class SecurityUserDetailsService implements UserDetailsService {

	@SuppressWarnings("deprecation")
	@Override
	public UserDetails loadUserByUsername(String username) {
		return User.withDefaultPasswordEncoder().username("user").password("user").roles("USER").build();
	}

}
