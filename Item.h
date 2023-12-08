#include <SFML/Graphics.hpp>
#include <iostream>
#include <string>
#include <vector>
#include <time.h>
#include <cmath>
#include <windows.h>

using namespace std;
using namespace sf;

class Item {

	double x, y, radius, color;
	CircleShape circle;

public:
	Item(double x = 0, double y = 0, double radius = 10, Color fillColor = Color::White) : x{ x }, y{ y }, radius{ radius } {
		circle.setRadius(radius);
		circle.setPosition(x, y);
		circle.setFillColor(fillColor);
		circle.setPointCount(50);
	}

	Color getColor();
	void setColor(Color fillColor);

	void setPosition(double x, double y);
	Vector2f getPosition();
	float getRadius();


	CircleShape* getCircleShape(); 
	int collisionTest(Item& obj);
};
