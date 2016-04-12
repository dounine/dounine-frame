package com.dounine.interceptor;

import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.FilterChain;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.ehcache.CacheException;
import net.sf.ehcache.constructs.blocking.LockTimeoutException;
import net.sf.ehcache.constructs.web.AlreadyCommittedException;
import net.sf.ehcache.constructs.web.AlreadyGzippedException;
import net.sf.ehcache.constructs.web.filter.FilterNonReentrantException;
import net.sf.ehcache.constructs.web.filter.SimplePageCachingFilter;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dounine.domain.system.cache.Filecache;
import com.dounine.enumtype.StatusType;
import com.dounine.service.system.cache.FilecacheService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.interceptor ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:27:18 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 链接缓存过滤器 ]
 */
public class PageEhCacheFilter extends SimplePageCachingFilter{

	private final static Logger log = LoggerFactory.getLogger(PageEhCacheFilter.class);
    	
    private static Set<String> cacheURLs;
    
    public static FilecacheService filecacheService;
    
    public synchronized static void init() throws CacheException {
    	Filecache _filecache = new Filecache();
    	_filecache.setRows(Integer.valueOf(String.valueOf(filecacheService.count(null))));
    	List<Filecache> filecaches = (List<Filecache>) filecacheService.select(_filecache);
    	if(null!=filecaches&&filecaches.size()>0){
    		cacheURLs = new HashSet<String>();
    		for(Filecache filecache : filecaches){
    			String resource = filecache.getFileCacheResource();
    			if(filecache.getStatus().equals(StatusType.NORMAL)){
    				if(StringUtils.contains(resource, "*.")){
        				cacheURLs.add(StringUtils.substring(resource, 1));
        			}else{
        				cacheURLs.add(resource);
        			}
    				cacheURLs.add(StringUtils.substring(resource, 1));
    			}
    		}
    	}
    }
    
    @Override
    protected void doFilter(final HttpServletRequest request,
            final HttpServletResponse response, final FilterChain chain)
            throws AlreadyGzippedException, AlreadyCommittedException,
            FilterNonReentrantException, LockTimeoutException, Exception {
        if (null==cacheURLs) {
            init();
        }
        
        String url = request.getRequestURI();
        boolean flag = false;
        if (null!=cacheURLs && cacheURLs.size() > 0) {
        	if(cacheURLs.contains(url)){
        		flag =  true;
        	}else{
        		for (String cacheURL : cacheURLs) {
        			if (StringUtils.contains(url, cacheURL.trim())||StringUtils.equals(url, cacheURL.trim())) {
        				flag = true;
        				break;
        			}
        		}
        	}
        }
        // 如果包含我们要缓存的url 就缓存该页面，否则执行正常的页面转向
        if (flag) {
            String query = request.getQueryString();
            if (StringUtils.isNotEmpty(query)) {
                query = "?" + query;
            }
            log.debug("当前请求被缓存：" + url + query);
            super.doFilter(request, response, chain);
        } else {
            chain.doFilter(request, response);
        }
    }
    
    private boolean headerContains(final HttpServletRequest request, final String header, final String value) {
        logRequestHeaders(request);
        final Enumeration<?> accepted = request.getHeaders(header);
        while (accepted.hasMoreElements()) {
            final String headerValue = (String) accepted.nextElement();
            if (headerValue.indexOf(value) != -1) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * @see net.sf.ehcache.constructs.web.filter.Filter#acceptsGzipEncoding(javax.servlet.http.HttpServletRequest)
     * <b>function:</b> 兼容ie6/7 gzip压缩
     * @author hoojo
     * @createDate 2012-7-4 上午11:07:11
     */
    @Override
    protected boolean acceptsGzipEncoding(HttpServletRequest request) {
        boolean ie6 = headerContains(request, "User-Agent", "MSIE 6.0");
        boolean ie7 = headerContains(request, "User-Agent", "MSIE 7.0");
        return acceptsEncoding(request, "gzip") || ie6 || ie7;
    }
}
