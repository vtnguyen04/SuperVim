#!/usr/bin/env python3
"""
Demo file để test SuperVim features
Sử dụng file này để test các tính năng:
- LSP autocompletion
- Python virtual environment
- Debugging
- Testing với pytest
- Git integration
"""

import math
from typing import List, Optional
from dataclasses import dataclass


@dataclass
class Point:
    """A point in 2D space."""
    x: float
    y: float

    def distance_to(self, other: 'Point') -> float:
        """Calculate distance to another point."""
        return math.sqrt((self.x - other.x) ** 2 + (self.y - other.y) ** 2)


class Calculator:
    """A simple calculator class for testing SuperVim features."""

    @staticmethod
    def add(a: float, b: float) -> float:
        """Add two numbers."""
        return a + b

    @staticmethod
    def multiply(a: float, b: float) -> float:
        """Multiply two numbers."""
        return a * b

    @staticmethod
    def divide(a: float, b: float) -> float:
        """Divide two numbers."""
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b

    def fibonacci(self, n: int) -> int:
        """Calculate fibonacci number recursively."""
        if n <= 1:
            return n
        return self.fibonacci(n - 1) + self.fibonacci(n - 2)

    def factorial(self, n: int) -> int:
        """Calculate factorial iteratively."""
        if n < 0:
            raise ValueError("Factorial not defined for negative numbers")

        result = 1
        for i in range(1, n + 1):
            result *= i
        return result

    def prime_numbers(self, limit: int) -> List[int]:
        """Generate prime numbers up to limit using Sieve of Eratosthenes."""
        if limit < 2:
            return []

        sieve = [True] * (limit + 1)
        sieve[0] = sieve[1] = False

        for i in range(2, int(math.sqrt(limit)) + 1):
            if sieve[i]:
                for j in range(i * i, limit + 1, i):
                    sieve[j] = False

        return [i for i in range(2, limit + 1) if sieve[i]]


def process_data(data: List[float]) -> dict:
    """Process a list of numbers and return statistics."""
    if not data:
        return {"error": "Empty data"}

    return {
        "count": len(data),
        "sum": sum(data),
        "mean": sum(data) / len(data),
        "min": min(data),
        "max": max(data),
        "sorted": sorted(data)
    }


def find_common_elements(list1: List[int], list2: List[int]) -> List[int]:
    """Find common elements between two lists."""
    return list(set(list1) & set(list2))


class DatabaseMock:
    """Mock database for testing purposes."""

    def __init__(self):
        self.data = {}
        self.connection_status = False

    def connect(self) -> bool:
        """Simulate database connection."""
        self.connection_status = True
        return True

    def disconnect(self):
        """Simulate database disconnection."""
        self.connection_status = False

    def insert(self, key: str, value: any) -> bool:
        """Insert data into mock database."""
        if not self.connection_status:
            raise ConnectionError("Database not connected")

        self.data[key] = value
        return True

    def get(self, key: str) -> Optional[any]:
        """Get data from mock database."""
        if not self.connection_status:
            raise ConnectionError("Database not connected")

        return self.data.get(key)

    def delete(self, key: str) -> bool:
        """Delete data from mock database."""
        if not self.connection_status:
            raise ConnectionError("Database not connected")

        if key in self.data:
            del self.data[key]
            return True
        return False


def main():
    """Main function to demonstrate SuperVim features."""
    print("🚀 SuperVim Demo Script")
    print("=" * 50)

    # Test Calculator class
    calc = Calculator()
    print(f"Addition: {calc.add(5, 3)}")
    print(f"Multiplication: {calc.multiply(4, 7)}")
    print(f"Division: {calc.divide(10, 2)}")
    print(f"Fibonacci(10): {calc.fibonacci(10)}")
    print(f"Factorial(5): {calc.factorial(5)}")
    print(f"Primes up to 30: {calc.prime_numbers(30)}")

    # Test Point class
    p1 = Point(0, 0)
    p2 = Point(3, 4)
    print(f"Distance between points: {p1.distance_to(p2)}")

    # Test data processing
    sample_data = [1, 5, 3, 8, 2, 9, 4, 7, 6]
    stats = process_data(sample_data)
    print(f"Data statistics: {stats}")

    # Test list operations
    list1 = [1, 2, 3, 4, 5]
    list2 = [4, 5, 6, 7, 8]
    common = find_common_elements(list1, list2)
    print(f"Common elements: {common}")

    # Test DatabaseMock
    db = DatabaseMock()
    db.connect()
    db.insert("user1", {"name": "Alice", "age": 30})
    db.insert("user2", {"name": "Bob", "age": 25})

    print(f"User1: {db.get('user1')}")
    print(f"User2: {db.get('user2')}")

    db.disconnect()
    print("Demo completed successfully! ✅")


if __name__ == "__main__":
    # Test với breakpoint (để demo debugging)
    # Đặt breakpoint tại đây với <Space>db
    main()

# ======================================================================
# INSTRUCTIONS FOR TESTING SUPERVIM:
# ======================================================================
#
# 1. LSP Features:
#    - Hover trên function để xem documentation (K)
#    - Go to definition (gd)
#    - Find references (gr)
#    - Rename symbol (<Space>rn)
#    - Code actions (<Space>ca)
#
# 2. Python Features:
#    - Select virtual environment (<Space>vs)
#    - Run tests (<Space>tr, <Space>tf)
#    - Debug code (<Space>db để set breakpoint, <Space>dc để start)
#
# 3. Git Features:
#    - Open LazyGit (<Space>gg)
#    - View diff (<Space>gd)
#    - Git blame (<Space>gb)
#
# 4. File Operations:
#    - Toggle file explorer (<Space>e)
#    - Find files (<Space>ff)
#    - Search text (<Space>fg)
#    - Recent files (<Space>fr)
#
# 5. Terminal:
#    - Float terminal (<Space>tf)
#    - Horizontal terminal (<Space>th)
#    - Vertical terminal (<Space>tv)
#
# ======================================================================