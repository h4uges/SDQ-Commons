package edu.kit.ipd.sdq.commons.util.java.lang

import org.eclipse.xtext.xbase.lib.Functions.Function1
import java.util.List
import java.util.ArrayList

/**
 * A utility class providing extension methods for Iterables
 * 
 */
class IterableUtil {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
	
	public static final def <T, R> List<R> mapFixed(Iterable<T> original, Function1<? super T, ? extends R> transformation) {
		val List<R> list = new ArrayList()
		for (T o : original) {
			list.add(transformation.apply(o))
		}
		return list
	}
	
	/**
	 * Returns the concatenated string representation of the elements in the given iterable. 
	 * The {@code separator} is used to between each pair of entries in the input.
	 * 
	 * @param iterable
	 *            the iterable. May not be <code>null</code>.
	 * @param before
	 *            prepends the resulting string if the iterable contains at least one element. May be <code>null</code> which is equivalent to passing an empty string.
	 * @param separator
	 *            the separator. May be <code>null</code> which is equivalent to passing an empty string.
	 * @param after
	 *            appended to the resulting string if the iterable contain at least one element. May be <code>null</code> which is equivalent to passing an empty string.
	 * @return the string representation of the iterable's elements. Never <code>null</code>.
	 *
	 * @see org.eclipse.xtext.xbase.lib.IterableExtensions#join(Iterable, CharSequence, CharSequence, CharSequence, Functions.Function1)
	 */
	public static final def String join(Iterable<? extends CharSequence> iterable, CharSequence before, CharSequence separator, CharSequence after) '''«
	FOR cs : iterable
		BEFORE before
		SEPARATOR separator
		AFTER after
		»«cs»«
	ENDFOR»'''
	
	/**
	 * Returns the number of times the element occurs in the collection.
	 */
	def static <T> int count(Iterable<T> coll, T element) {
		var count = 0
		for (T pivot : coll) {
			if (pivot == element) {
				count++
			}
		}
		return count
	}
	
	/**
	 * Checks if the given {@link Iterable} contains only one element and returns it.
	 * Otherwise, an exception is thrown.
	 * 
	 * @param iterable -
	 *			the {@link Iterable}. May not be <code>null</code>.
	 * @return the only element in the given {@link Iterable}. Never <code>null</code>.
	 * 
	 * @throws IllegaStateException if the given {@link Iterable} does not contain exactly one element
	 */
	def static final <A extends Iterable<T>, T> T claimOne(A iterable) {
		val iterator = iterable.iterator();
		if (iterator.hasNext()) {
			val one = iterator.next();
	        if (!iterator.hasNext()) {
	        	return one;
	        }
		}
		throw new IllegalStateException("It was claimed that the collection '" + iterable + "' contains exactly one element!");
	}
	
	/**
	 * Checks if the given {@link Iterable} is empty.
	 * Otherwise, an exception is thrown.
	 * 
	 * @param iterable -
	 *			the {@link Iterable}. May not be <code>null</code>.
	 * @return the given {@link Iterable}.
	 * 
	 * @throws IllegaStateException if the given {@link Iterable} is empty
	 */
	def static final <A extends Iterable<?>> A claimNotEmpty(A iterable) {
	    if (iterable.size() == 0) {
	        throw new IllegalStateException("It was claimed that the collection '" + iterable + "' is not empty!");
	    }
	    return iterable;
	}
}